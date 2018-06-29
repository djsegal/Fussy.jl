mutable struct Scan <: AbstractScan
  T_bar_list::Vector{AbstractFloat}

  deck::Union{Void, Symbol}

  beta_reactors::Vector{AbstractReactor}
  kink_reactors::Vector{AbstractReactor}
  pcap_reactors::Vector{AbstractReactor}
  wall_reactors::Vector{AbstractReactor}
  heat_reactors::Vector{AbstractReactor}
end

function Scan(cur_T_bar_list::Any, cur_limit::Symbol; cur_kwargs...)
  cur_dict = merge!(Dict(), Dict(cur_kwargs))

  Scan(cur_T_bar_list, [cur_limit], cur_dict)
end

function Scan(cur_T_bar_list::Any, cur_limits::AbstractArray=collect(keys(secondary_limits)); cur_kwargs...)
  cur_dict = merge!(Dict(), Dict(cur_kwargs))

  Scan(cur_T_bar_list, cur_limits, cur_dict)
end

function Scan(cur_T_bar_list::Any, cur_limits::AbstractArray, cur_dict::Dict)
  cur_deck = haskey(cur_dict, :deck) ?
    cur_dict[:deck] : nothing

  roots_count = max_roots
  limit_count = length(cur_limits)
  T_bar_count = length(cur_T_bar_list)

  reactor_count = T_bar_count * limit_count

  cur_scan = Scan(
    cur_T_bar_list, cur_deck,
    [ AbstractReactor[] for cur_index in 1:length(keys(secondary_limits)) ]...
  )

  cur_array = SharedArray{Float64}(limit_count, T_bar_count, roots_count)
  fill!(cur_array, NaN)

  cur_func = function (cur_index::Integer)
    cur_row = fld(cur_index-1, T_bar_count) + 1
    cur_col = mod(cur_index-1, T_bar_count) + 1

    cur_limit = cur_limits[cur_row]
    cur_T_bar = cur_scan.T_bar_list[cur_col]

    cur_reactor = Reactor(
      cur_T_bar, merge(cur_dict, Dict(Symbol("constraint") => cur_limit))
    )

    cur_I_P_list = solve(cur_reactor)
    cur_array[cur_row, cur_col, 1:length(cur_I_P_list)] = cur_I_P_list
  end

  cur_progress = Progress(reactor_count)
  pmap(cur_func, cur_progress, 1:reactor_count)

  for cur_row in 1:limit_count

    cur_max_roots = maximum(
        map(cur_col -> max_roots - count(isnan, cur_array[cur_row, cur_col, :]), 1:length(cur_T_bar_list))
    )

    has_branches_enabled = cur_max_roots > 1
    if has_branches_enabled
      cur_point_indices = find(
          cur_col -> count(isnan, cur_array[cur_row, cur_col, :]) == ( max_roots - cur_max_roots ), 1:length(cur_T_bar_list)
      )

      has_branches_enabled &= ( length(cur_point_indices) > 2 )
    end

    if has_branches_enabled
      ( cur_branch_T_lists, cur_branch_I_lists ) =
        _get_branch_lists(cur_array[cur_row,:,:], cur_T_bar_list)
    else
      cur_branch_T_lists = [ Real[] ]
      cur_branch_I_lists = [ Real[] ]

      for (cur_col, cur_T_bar) in enumerate(cur_scan.T_bar_list)
        for cur_I_P in cur_array[cur_row, cur_col, :]
          isnan(cur_I_P) && break
          push!(cur_branch_T_lists[1], cur_T_bar)
          push!(cur_branch_I_lists[1], cur_I_P)
        end
      end
    end

    cur_limit = cur_limits[cur_row]
    cur_field_symbol = Symbol("$(cur_limit)_reactors")

    cur_reactor_list = getfield(cur_scan, cur_field_symbol)

    for (cur_index, (cur_branch_T_list, cur_branch_I_list)) in enumerate(zip(cur_branch_T_lists, cur_branch_I_lists))
      for (cur_T_bar, cur_I_P) in zip(cur_branch_T_list, cur_branch_I_list)
        cur_reactor = Reactor(
          cur_T_bar, merge(cur_dict, Dict(Symbol("constraint") => cur_limit))
        )

        cur_reactor.I_P = cur_I_P
        cur_reactor.branch_id = cur_index
        push!(cur_reactor_list, update!(cur_reactor))
      end
    end
  end

  cur_scan
end

function _get_branch_lists(cur_array::Matrix, cur_x_list)
  cur_max_roots = maximum(
      map(cur_row -> max_roots - count(isnan, cur_array[cur_row, :]), 1:length(cur_x_list))
  )

  cur_point_indices = find(
      cur_row -> count(isnan, cur_array[cur_row, :]) == ( max_roots - cur_max_roots ), 1:length(cur_x_list)
  )

  cur_branch_x_lists = [ Real[] for cur_index in 1:cur_max_roots ]
  cur_branch_y_lists = [ Real[] for cur_index in 1:cur_max_roots ]

  for (cur_index, cur_row) in enumerate(cur_point_indices)
      cur_x = cur_x_list[cur_row]
      for (cur_sub_index, cur_y) in enumerate(cur_array[cur_row, 1:cur_max_roots])
          push!(cur_branch_x_lists[cur_sub_index], cur_x)
          push!(cur_branch_y_lists[cur_sub_index], cur_y)
      end
  end

  cur_branch_fits = []

  for (cur_branch_x_list, cur_branch_y_list) in zip(cur_branch_x_lists, cur_branch_y_lists)
      cur_fit_params = poly_fit(cur_branch_x_list, cur_branch_y_list, 2)
      cur_fit = (cur_x) -> cur_fit_params[1] + cur_fit_params[2]*cur_x + cur_fit_params[3]*cur_x^2

      push!(cur_branch_fits, cur_fit)
  end

  for (cur_row, cur_x) in enumerate(cur_x_list)
    expected_values = map(cur_fit -> cur_fit(cur_x), cur_branch_fits)
    actual_values = filter(!isnan, cur_array[cur_row, :])

    ( 0 < length(actual_values) < length(expected_values) ) || continue

    cur_matrix = nothing

    cur_actual_values = deepcopy(actual_values)
    cur_used_indices = Int[]

    while !isempty(cur_actual_values)
      cur_matrix = Matrix(length(expected_values), length(cur_actual_values))
      for (cur_index, cur_expected_value) in enumerate(expected_values)
        for (cur_sub_index, cur_actual_value) in enumerate(cur_actual_values)
          if in(cur_index, cur_used_indices)
            cur_matrix[cur_index, cur_sub_index] = Inf
          else
            cur_matrix[cur_index, cur_sub_index] = abs(cur_expected_value - cur_actual_value)
          end
        end
      end

      (tmp_index, tmp_sub_index) = ind2sub(size(cur_matrix),indmin(cur_matrix))

      push!(cur_used_indices, tmp_index)
      push!(cur_branch_x_lists[tmp_index], cur_x)
      push!(cur_branch_y_lists[tmp_index], cur_actual_values[tmp_sub_index])

      deleteat!(cur_actual_values, tmp_sub_index)
    end

    sort!(cur_used_indices)
    sorted_y_list = sort(map(last, cur_branch_y_lists[cur_used_indices]))

    for (cur_index, cur_sub_index) in enumerate(cur_used_indices)
      cur_branch_y_lists[cur_sub_index][end] = sorted_y_list[cur_index]
    end
  end

  return ( cur_branch_x_lists, cur_branch_y_lists )
end
