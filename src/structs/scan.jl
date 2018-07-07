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
  cur_is_consistent = (
    haskey(cur_dict, :is_consistent) && cur_dict[:is_consistent]
  )

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

    tmp_dict = merge(
      cur_dict, Dict(:constraint => cur_limit)
    )

    if cur_is_consistent
      cur_root_list = converge(cur_T_bar, tmp_dict)
    else
      cur_reactor = Reactor(cur_T_bar, tmp_dict)

      cur_root_list = solve(cur_reactor)
    end

    cur_array[cur_row, cur_col, 1:length(cur_root_list)] = cur_root_list
  end

  cur_progress = Progress(reactor_count)
  pmap(cur_func, cur_progress, shuffle(1:reactor_count))

  omitted_root_count = 0

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
      ( cur_branch_x_lists, cur_branch_y_lists ) =
        _get_branch_lists(cur_array[cur_row,:,:], cur_T_bar_list)
    else
      cur_branch_x_lists = [ Real[] ]
      cur_branch_y_lists = [ Real[] ]

      for (cur_col, cur_T_bar) in enumerate(cur_scan.T_bar_list)
        cur_root_list = cur_array[cur_row, cur_col, :]
        filter!(!isnan, cur_root_list)

        isempty(cur_root_list) && continue

        if cur_is_consistent
          ( length(cur_root_list) > 1 ) && ( omitted_root_count += 1 )

          ( omitted_root_count == 5 ) &&
            println("*** ALERT *** 5 or more omitted roots!")

          cur_root_list = cur_root_list[end:end]
        end

        for cur_root in cur_root_list
          push!(cur_branch_x_lists[1], cur_T_bar)
          push!(cur_branch_y_lists[1], cur_root)
        end
      end
    end

    cur_limit = cur_limits[cur_row]
    cur_field_symbol = Symbol("$(cur_limit)_reactors")

    cur_reactor_list = getfield(cur_scan, cur_field_symbol)

    for (cur_index, (cur_branch_x_list, cur_branch_y_list)) in enumerate(zip(cur_branch_x_lists, cur_branch_y_lists))
      for (cur_T_bar, cur_root) in zip(cur_branch_x_list, cur_branch_y_list)
        cur_reactor = Reactor(
          cur_T_bar, merge(cur_dict, Dict(Symbol("constraint") => cur_limit))
        )

        if cur_is_consistent
          cur_reactor.eta_CD = cur_root

          solve!(cur_reactor)
        else
          cur_reactor.I_P = cur_root

          cur_reactor.is_solved = true
          cur_reactor.is_good = true

          update!(cur_reactor)
        end

        cur_reactor.branch_id = cur_index
        push!(cur_reactor_list, cur_reactor)
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

  long_stride = []
  work_stride = []

  for cur_index in cur_point_indices
    if isempty(work_stride) || work_stride[end] == cur_index - 1
      push!(work_stride, cur_index)
      continue
    end

    ( length(long_stride) < length(work_stride) ) &&
      ( long_stride = work_stride[:] )

    work_stride = [cur_index]
  end

  ( length(long_stride) < length(work_stride) ) &&
    ( long_stride = work_stride[:] )

  cur_point_indices = long_stride

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
    cur_fit = polyfit(Vector{Float64}(cur_branch_x_list), Vector{Float64}(cur_branch_y_list), 2)
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
