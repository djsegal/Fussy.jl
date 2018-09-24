mutable struct Study <: AbstractStudy
  parameter_list::Vector{AbstractFloat}

  parameter::Symbol

  default::Real
  sensitivity::Real
  num_points::Int

  deck::Union{Void, Symbol}

  kink_reactors::Vector{Reactor}
  wall_reactors::Vector{Reactor}

  cost_reactors::Vector{Reactor}
  W_M_reactors::Vector{Reactor}
end

function Study(cur_parameter, init_dict=Dict(); sensitivity=0.2, num_points=9, verbose::Bool=true, is_parallel::Bool=true, skip_center::Bool=false, deck=nothing, cur_kwargs...)
  cur_dict = deepcopy(init_dict)

  merge!(cur_dict, Dict(cur_kwargs))

  cur_is_light = haskey(cur_dict, :is_light) && cur_dict[:is_light]
  cur_is_fast = haskey(cur_dict, :is_fast) && cur_dict[:is_fast]

  delete!(cur_dict, :is_fast)
  delete!(cur_dict, :is_light)

  @assert isodd(num_points)

  if haskey(cur_dict, :deck)
    ( deck == nothing ) &&
      ( deck = cur_dict[:deck] )
  else
    cur_dict[:deck] = deck
  end

  cur_dict[:constraint] = :beta

  cur_reactor = Reactor(symbols(:T_bar), cur_dict)

  med_value = getfield(cur_reactor, cur_parameter)

  if num_points == 1
    parameter_list = [med_value]
  else
    min_value = med_value * ( 1.0 - sensitivity )
    max_value = med_value * ( 1.0 + sensitivity )

    parameter_list = collect(linspace(min_value, max_value, num_points))
  end

  if skip_center
    deleteat!(parameter_list, 1+Int((num_points-1)/2))
    num_points -= 1
  end

  cur_study = Study(
    parameter_list, cur_parameter,
    med_value, sensitivity,
    num_points, deck,
    [], [], [], []
  )

  if haskey(cur_dict, :is_consistent) && cur_dict[:is_consistent]
    tmp_dict = deepcopy(cur_dict)
    delete!(tmp_dict, :is_consistent)
    other_reactor = Reactor(symbols(:T_bar), tmp_dict)

    cur_reactor.eta_CD = other_reactor.eta_CD
  end

  cur_bad_indices = []
  for (cur_index, cur_value) in enumerate(parameter_list)
    tmp_dict = deepcopy(cur_dict)
    tmp_dict[cur_parameter] = cur_value

    other_reactor = Reactor(symbols(:T_bar), tmp_dict)
    ( other_reactor.is_good ) || push!(cur_bad_indices, cur_index)
  end

  num_points -= length(cur_bad_indices)
  deleteat!(parameter_list, cur_bad_indices)

  cur_input = [cur_study, cur_parameter, parameter_list, cur_dict, num_points, verbose, is_parallel]

  if !cur_is_light
    _make_kink_study_reactors(cur_input...)
    sleep(0.5)
  end

  _make_wall_study_reactors(cur_input...)

  if !cur_is_fast
    sleep(0.5)
    _make_min_study_reactors(:cost, cur_input...)
    _make_min_study_reactors(:W_M, cur_input...)
  end

  cur_study
end

function _make_kink_study_reactors(cur_study, cur_parameter, parameter_list, cur_dict, num_points, verbose, is_parallel)
  cur_array = SharedArray{Float64}(num_points, 3)
  fill!(cur_array, NaN)

  cur_func = function (cur_index::Integer)
    tmp_dict = deepcopy(cur_dict)
    tmp_dict[cur_parameter] = parameter_list[cur_index]

    tmp_reactor = Reactor(symbols(:T_bar), tmp_dict)

    if tmp_reactor.is_consistent
      cur_reactor = hone(tmp_reactor, :kink)
    else
      cur_reactor = match(tmp_reactor, :kink)
    end

    ( cur_reactor == nothing ) && return

    cur_array[cur_index,1] = cur_reactor.T_bar
    cur_array[cur_index,2] = cur_reactor.I_P
    cur_array[cur_index,3] = cur_reactor.eta_CD
  end

  if is_parallel
    if verbose
      cur_progress = Progress(num_points)
      pmap(cur_func, cur_progress, shuffle(1:num_points))
    else
      pmap(cur_func, shuffle(1:num_points))
    end
  else
    if verbose
      @showprogress [cur_func(tmp_index) for tmp_index in 1:num_points]
    else
      [cur_func(tmp_index) for tmp_index in 1:num_points]
    end
  end

  _make_study_reactors!(cur_study.kink_reactors, cur_parameter, parameter_list, cur_dict, cur_array)
end

function _make_wall_study_reactors(cur_study, cur_parameter, parameter_list, cur_dict, num_points, verbose, is_parallel)
  cur_array = SharedArray{Float64}(num_points, 3)
  fill!(cur_array, NaN)

  cur_func = function (cur_index::Integer)
    tmp_dict = deepcopy(cur_dict)
    tmp_dict[cur_parameter] = parameter_list[cur_index]

    tmp_reactor = Reactor(symbols(:T_bar), tmp_dict)

    if tmp_reactor.is_consistent
      cur_reactor = hone(tmp_reactor, :wall)
    else
      cur_reactor = match(tmp_reactor, :wall)
    end

    ( cur_reactor == nothing ) && return

    cur_array[cur_index,1] = cur_reactor.T_bar
    cur_array[cur_index,2] = cur_reactor.I_P
    cur_array[cur_index,3] = cur_reactor.eta_CD
  end

  if is_parallel
    if verbose
      cur_progress = Progress(num_points)
      pmap(cur_func, cur_progress, shuffle(1:num_points))
    else
      pmap(cur_func, shuffle(1:num_points))
    end
  else
    if verbose
      @showprogress [cur_func(tmp_index) for tmp_index in 1:num_points]
    else
      [cur_func(tmp_index) for tmp_index in 1:num_points]
    end
  end

  _make_study_reactors!(cur_study.wall_reactors, cur_parameter, parameter_list, cur_dict, cur_array)
end

function _make_min_study_reactors(cur_field, cur_study, cur_parameter, parameter_list, cur_dict, num_points, verbose, is_parallel)
  cur_array = SharedArray{Float64}(num_points, 3)
  fill!(cur_array, NaN)

  cur_constraints = SharedArray{Int}(num_points, 1)

  cur_func = function (cur_index::Integer)
    cur_parameter_value = parameter_list[cur_index]

    tmp_dict = deepcopy(cur_dict)
    tmp_dict[cur_parameter] = cur_parameter_value

    tmp_reactor = Reactor(symbols(:T_bar), tmp_dict)

    init_reactor = nothing
    for cur_study_reactors in [cur_study.kink_reactors, cur_study.wall_reactors]
      filtered_study_reactors = filter(
        study_reactor -> getfield(study_reactor, cur_parameter) == cur_parameter_value,
        cur_study_reactors
      )

      isempty(filtered_study_reactors) && continue
      init_reactor = first(filtered_study_reactors)
      break
    end

    min_reactor = nothing

    cur_keys = collect(keys(secondary_limits))

    filter!(cur_key -> !in(cur_key, tmp_reactor.skipped_limits), cur_keys)
    filter!(cur_key -> !in(cur_key, tmp_reactor.ignored_limits), cur_keys)

    has_made_change = true
    while has_made_change
      has_made_change = false
      for cur_key in cur_keys
        ( is_present(min_reactor) && cur_key == min_reactor.constraint ) && continue
        tmp_reactor.constraint = cur_key

        tmp_min_reactor = minimize(tmp_reactor, cur_field, min_reactor)
        is_nothing(tmp_min_reactor) && continue

        has_made_change |= is_nothing(min_reactor)
        has_made_change = has_made_change || ( abs( min_reactor.cost - tmp_min_reactor.cost ) > 5e-5 )

        min_reactor = tmp_min_reactor
      end
      has_made_change &= is_present(min_reactor)
    end

    is_nothing(min_reactor) && return

    cur_array[cur_index,1] = min_reactor.T_bar
    cur_array[cur_index,2] = min_reactor.I_P
    cur_array[cur_index,3] = min_reactor.eta_CD

    cur_constraints[cur_index] = findfirst(tmp_constraint -> tmp_constraint == min_reactor.constraint, collect(keys(secondary_limits)))
  end

  if is_parallel
    if verbose
      cur_progress = Progress(num_points)
      pmap(cur_func, cur_progress, shuffle(1:num_points))
    else
      pmap(cur_func, shuffle(1:num_points))
    end
  else
    if verbose
      @showprogress [cur_func(tmp_index) for tmp_index in 1:num_points]
    else
      [cur_func(tmp_index) for tmp_index in 1:num_points]
    end
  end

  cur_reactors = getfield(cur_study, Symbol("$(cur_field)_reactors"))

  _make_study_reactors!(cur_reactors, cur_parameter, parameter_list, cur_dict, cur_array, cur_constraints)
end

function _make_study_reactors!(cur_reactors, cur_parameter, parameter_list, cur_dict, cur_array, cur_constraints=nothing)
  for (cur_index, cur_value) in enumerate(parameter_list)
    cur_T_bar, cur_I_P, cur_eta_CD = cur_array[cur_index,:]

    isnan(cur_eta_CD) && continue
    isnan(cur_T_bar) && continue
    isnan(cur_I_P) && continue

    tmp_dict = deepcopy(cur_dict)
    tmp_dict[cur_parameter] = parameter_list[cur_index]

    is_nothing(cur_constraints) ||
      ( tmp_dict[:constraint] = collect(keys(secondary_limits))[cur_constraints[cur_index]] )

    work_reactor = Reactor(cur_T_bar, tmp_dict)
    work_reactor.I_P = cur_I_P
    work_reactor.eta_CD = cur_eta_CD

    push!(cur_reactors, update!(work_reactor))
  end
end
