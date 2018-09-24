mutable struct Scan <: AbstractScan
  T_bar_list::Vector{AbstractFloat}

  deck::Union{Void, Symbol}

  beta_reactors::Vector{Reactor}
  kink_reactors::Vector{Reactor}
  pcap_reactors::Vector{Reactor}
  wall_reactors::Vector{Reactor}
  heat_reactors::Vector{Reactor}
end

function Scan(cur_T_bar_list::Any, cur_limit::Symbol; cur_kwargs...)
  cur_dict = merge!(Dict(), Dict(cur_kwargs))

  Scan(cur_T_bar_list, [cur_limit], cur_dict)
end

function Scan(cur_T_bar_list::Any; cur_kwargs...)
  cur_T_bar_list = collect(cur_T_bar_list)

  cur_dict = merge!(Dict(), Dict(cur_kwargs))

  cur_limits = collect(keys(secondary_limits))

  if haskey(cur_dict, :deck)
    tmp_reactor = Reactor(symbols(:T_bar), deck=cur_dict[:deck])

    cur_skipped_limits = tmp_reactor.skipped_limits
    filter!(cur_limit -> !in(cur_limit, cur_skipped_limits), cur_limits)

    cur_ignored_limits = tmp_reactor.ignored_limits
    filter!(cur_limit -> !in(cur_limit, cur_ignored_limits), cur_limits)
  end

  Scan(cur_T_bar_list, cur_limits, cur_dict)
end

function Scan(cur_T_bar_list::Any, cur_limits::AbstractArray; cur_kwargs...)
  cur_dict = merge!(Dict(), Dict(cur_kwargs))

  Scan(cur_T_bar_list, cur_limits, cur_dict)
end

function Scan(cur_T_bar_list::Any, cur_limits::AbstractArray, cur_dict::Dict)
  isa(cur_T_bar_list, AbstractArray) ||
    ( cur_T_bar_list = [ cur_T_bar_list ] )

  cur_is_consistent = (
    haskey(cur_dict, :is_consistent) && cur_dict[:is_consistent]
  )

  cur_deck = haskey(cur_dict, :deck) ?
    cur_dict[:deck] : nothing

  roots_count = max_roots
  limit_count = length(cur_limits)
  T_bar_count = length(cur_T_bar_list)

  reactor_count = T_bar_count * limit_count

  if !haskey(cur_dict, :is_parallel)
    cur_is_parallel = true
  else
    cur_is_parallel = cur_dict[:is_parallel]
    delete!(cur_dict, :is_parallel)
  end

  if !haskey(cur_dict, :verbose)
    cur_verbose = true
  else
    cur_verbose = cur_dict[:verbose]
    delete!(cur_dict, :verbose)
  end

  cur_scan = Scan(
    cur_T_bar_list, cur_deck,
    [ Reactor[] for cur_index in 1:length(keys(secondary_limits)) ]...
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

  if cur_is_parallel
    if cur_verbose
      cur_progress = Progress(reactor_count)
      pmap(cur_func, cur_progress, shuffle(1:reactor_count))
    else
      pmap(cur_func, shuffle(1:reactor_count))
    end
  else
    @showprogress [cur_func(tmp_index) for tmp_index in shuffle(1:reactor_count)]
  end

  omitted_root_count = 0

  for cur_row in 1:limit_count

    cur_max_roots = maximum(
        map(cur_col -> max_roots - count(isnan, cur_array[cur_row, cur_col, :]), 1:length(cur_T_bar_list))
    )

    if cur_max_roots > 1
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
            custom_log("*** ALERT *** 5 or more omitted roots!")

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

        if !cur_reactor.is_good
          @assert !cur_reactor.is_pulsed
          @assert !cur_reactor.is_consistent
          continue
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

  prev_stride = reverse(collect( 1 : long_stride[1]-1 ))
  next_stride = collect( long_stride[end]+1 : length(cur_x_list) )

  if isempty(prev_stride) || isempty(next_stride)
    cur_row_list = []
  else
    cur_row_list = collect(
      Iterators.flatten(zip(prev_stride, next_stride))
    )
  end

  ( length(prev_stride) < length(next_stride) ) &&
    append!(cur_row_list, next_stride[length(prev_stride)+1:end])

  ( length(prev_stride) > length(next_stride) ) &&
    append!(cur_row_list, prev_stride[length(next_stride)+1:end])

  for cur_row in cur_row_list
    cur_x = cur_x_list[cur_row]

    cur_branch_fits = []

    for (cur_branch_x_list, cur_branch_y_list) in zip(cur_branch_x_lists, cur_branch_y_lists)
      cur_fit = _make_scan_polyfit(cur_branch_x_list, cur_branch_y_list, cur_x)
      push!(cur_branch_fits, cur_fit)
    end

    expected_values = map(cur_fit -> cur_fit(cur_x), cur_branch_fits)
    actual_values = filter(!isnan, cur_array[cur_row, :])

    iszero(length(actual_values)) && continue

    cur_matrix = nothing

    cur_actual_values = deepcopy(actual_values)
    cur_used_indices = Int[]

    while !isempty(cur_actual_values)

      cur_index_pair = nothing

      cur_matrix = Matrix(length(expected_values), length(cur_actual_values))
      fill!(cur_matrix, Inf)

      for (cur_sub_index, cur_actual_value) in enumerate(cur_actual_values)
        cur_used_y_list = map(last, cur_branch_y_lists[cur_used_indices])

        for cur_index in 1:length(expected_values)
          in(cur_index, cur_used_indices) && continue

          cur_skipped_count = minimum( abs.( cur_branch_x_lists[cur_index] - cur_x ) )
          cur_skipped_count /= minimum( diff(cur_x_list) )
          cur_skipped_count = round(cur_skipped_count) - 1

          cur_value = abs( expected_values[cur_index] - cur_actual_value )
          cur_value /= abs( cur_actual_value )
          cur_value *= sqrt( cur_skipped_count + 1 )

          cur_matrix[cur_index, cur_sub_index] = cur_value
        end
      end

      cur_min_error, cur_min_index = findmin(cur_matrix)
      isfinite(cur_min_error) &&
        ( cur_index_pair = ind2sub(size(cur_matrix),cur_min_index) )

      if cur_index_pair == nothing
        @assert length(cur_actual_values) == 1
        tmp_sub_index = 1

        push!(cur_branch_x_lists, [])
        push!(cur_branch_y_lists, [])
        tmp_index = length(cur_branch_x_lists)
      else
        (tmp_index, tmp_sub_index) = cur_index_pair
      end

      push!(cur_used_indices, tmp_index)
      sort!(cur_used_indices)

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

  new_branch_x_list, new_branch_y_list = [], []

  for (cur_index, (cur_branch_x_list, cur_branch_y_list)) in enumerate(zip(cur_branch_x_lists, cur_branch_y_lists))
    sort_lists!(cur_branch_x_list, cur_branch_y_list)

    work_y_list = cur_branch_y_list[:]
    filter_approx!(work_y_list)

    ( length(work_y_list) == 1 ) && continue

    cur_diff_list = diff(work_y_list)

    cur_flips = 0
    cur_direction = sign(cur_diff_list[1])

    for cur_diff in cur_diff_list[2:end]
      iszero(cur_diff) && continue

      tmp_direction = sign(cur_diff)
      ( cur_direction == tmp_direction ) && continue

      cur_flips += 1
      cur_direction = tmp_direction
    end

    ( cur_flips < 3 ) && continue

    ( cur_flips > 3 ) && continue

    cur_max_value = maximum(work_y_list)
    cur_max_index = findfirst(work_y -> work_y == cur_max_value, cur_branch_y_list)
    cur_max_space = cur_branch_x_list[cur_max_index]

    cur_bot_branch_x_list = cur_branch_x_list[1:cur_max_index-1]
    cur_bot_branch_y_list = cur_branch_y_list[1:cur_max_index-1]

    cur_top_branch_x_list = cur_branch_x_list[cur_max_index+1:end]
    cur_top_branch_y_list = cur_branch_y_list[cur_max_index+1:end]

    cur_bot_fit = _make_scan_polyfit(cur_bot_branch_x_list, cur_bot_branch_y_list, cur_max_space)
    cur_top_fit = _make_scan_polyfit(cur_top_branch_x_list, cur_top_branch_y_list, cur_max_space)

    cur_bot_error = abs( cur_max_value - cur_bot_fit(cur_max_space) )
    cur_top_error = abs( cur_max_value - cur_top_fit(cur_max_space) )

    if cur_bot_error < cur_top_error
      push!(cur_bot_branch_x_list, cur_max_space)
      push!(cur_bot_branch_y_list, cur_max_value)
    else
      unshift!(cur_top_branch_x_list, cur_max_space)
      unshift!(cur_top_branch_y_list, cur_max_value)
    end

    cur_branch_x_lists[cur_index] = cur_bot_branch_x_list
    cur_branch_y_lists[cur_index] = cur_bot_branch_y_list

    push!(new_branch_x_list, cur_top_branch_x_list)
    push!(new_branch_y_list, cur_top_branch_y_list)
  end

  append!(cur_branch_x_lists, new_branch_x_list)
  append!(cur_branch_y_lists, new_branch_y_list)

  return ( cur_branch_x_lists, cur_branch_y_lists )
end

function _make_scan_polyfit(cur_x_list, cur_y_list, cur_x)
  if length(cur_x_list) == 3
    cur_order = 1
    cur_range = ( cur_x < first(cur_x_list) ) ? (1:2) : (2:3)

    tmp_x_list = Vector{Float64}(cur_x_list[cur_range])
    tmp_y_list = Vector{Float64}(cur_y_list[cur_range])

    cur_fit = polyfit(tmp_x_list, tmp_y_list, cur_order)

    return cur_fit
  end

  work_x_list = deepcopy(cur_x_list)
  work_y_list = deepcopy(cur_y_list)

  tmp_x_list = Float64[]
  tmp_y_list = Float64[]

  for cur_point in 1:min(5, length(cur_x_list))
    cur_min_index = indmin( abs.( work_x_list - cur_x ) )

    push!(tmp_x_list, work_x_list[cur_min_index])
    push!(tmp_y_list, work_y_list[cur_min_index])

    deleteat!(work_x_list, cur_min_index)
    deleteat!(work_y_list, cur_min_index)
  end

  cur_order = min(2, length(tmp_x_list) - 1)

  cur_fit = polyfit(tmp_x_list, tmp_y_list, cur_order)

  cur_fit
end
