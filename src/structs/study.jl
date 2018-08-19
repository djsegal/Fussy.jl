mutable struct Study <: AbstractStudy
  parameter_list::Vector{AbstractFloat}

  parameter::Symbol

  default::Real
  sensitivity::Real
  num_points::Int

  deck::Union{Void, Symbol}

  kink_reactors::Vector{AbstractReactor}
  wall_reactors::Vector{AbstractReactor}
  cost_reactors::Vector{AbstractReactor}

  top_R_0_reactors::Vector{AbstractReactor}
  top_B_0_reactors::Vector{AbstractReactor}

  mid_R_0_reactors::Vector{AbstractReactor}
  mid_B_0_reactors::Vector{AbstractReactor}

  bot_R_0_reactors::Vector{AbstractReactor}
  bot_B_0_reactors::Vector{AbstractReactor}
end

function Study(cur_parameter, init_dict=Dict(); sensitivity=0.2, num_points=9, verbose::Bool=true, is_parallel::Bool=true, skip_center::Bool=false, deck=nothing, cur_kwargs...)
  cur_dict = deepcopy(init_dict)

  merge!(cur_dict, Dict(cur_kwargs))

  cur_is_fast = safe_get(cur_dict, :is_fast, true)
  cur_is_light = haskey(cur_dict, :is_light) && cur_dict[:is_light]

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
    [], [], [], [], [], [], [], [], []
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

    for cur_scalar in [0.5, 1.0, 1.5]
      _make_some_study_reactors(:R_0, cur_scalar, cur_input...)
      _make_some_study_reactors(:B_0, cur_scalar, cur_input...)
    end

    sleep(0.5)
  end

  _make_wall_study_reactors(cur_input...)

  if !cur_is_fast && !cur_reactor.is_consistent
    sleep(0.5)
    _make_cost_study_reactors(cur_input...)
  end

  cur_study
end

function cost_minimization(cur_reactor::AbstractReactor)
  cur_func = function (cur_T::Number)
    tmp_reactor = deepcopy(cur_reactor)
    tmp_reactor.T_bar = cur_T

    cur_I_P_list = Fussy.solve(tmp_reactor)
    isempty(cur_I_P_list) && return NaN

    cur_cost = Inf
    for cur_I_P in cur_I_P_list
      work_reactor = deepcopy(tmp_reactor)
      work_reactor.I_P = cur_I_P
      Fussy.update!(work_reactor)

      work_reactor.is_valid || continue
      cur_cost = min(cur_cost, work_reactor.cost)
    end

    cur_cost
  end

  cur_func
end

function find_min_cost_reactor(cur_reactor::Fussy.AbstractReactor, cur_min_T::Number=Fussy.min_T_bar, cur_max_T::Number=Fussy.max_T_bar; no_pts::Int=41, atol=1e-8, rtol=3e-3)
  @assert !cur_reactor.is_consistent

  cur_min_T, cur_max_T =
    min(cur_min_T, cur_max_T),
    max(cur_min_T, cur_max_T)

  cur_min_T, cur_cost = minimize(cost_minimization(cur_reactor), cur_min_T, cur_max_T, no_pts=no_pts, atol=atol, rtol=rtol)

  isnan(cur_min_T) && return nothing
  isnan(cur_cost) && return nothing

  min_cost_reactor = deepcopy(cur_reactor)

  min_cost_reactor.T_bar = cur_min_T

  min_cost_reactor = find_low_cost_reactor(min_cost_reactor)

  min_cost_reactor
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
    @showprogress [cur_func(tmp_index) for tmp_index in shuffle(1:num_points)]
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
    @showprogress [cur_func(tmp_index) for tmp_index in shuffle(1:num_points)]
  end

  _make_study_reactors!(cur_study.wall_reactors, cur_parameter, parameter_list, cur_dict, cur_array)
end

function _make_some_study_reactors(cur_field, cur_scalar, cur_study, cur_parameter, parameter_list, cur_dict, num_points, verbose, is_parallel)
  cur_array = SharedArray{Float64}(num_points, 3)
  fill!(cur_array, NaN)

  cur_func = function (cur_index::Integer)
    tmp_dict = deepcopy(cur_dict)
    tmp_dict[cur_parameter] = parameter_list[cur_index]

    tmp_reactor = Reactor(symbols(:T_bar), tmp_dict)

    if haskey(tmp_dict, :deck)
      cur_solution_symbol = Symbol("$(tmp_dict[:deck])_solution")
      if isdefined(Fussy, cur_solution_symbol)
        cur_value = getfield(getfield(Fussy, cur_solution_symbol)(), cur_field)
      else
        cur_value = getfield(Fussy, Symbol("assumed_$(cur_field)"))
      end
    else
      cur_value = getfield(Fussy, Symbol("assumed_$(cur_field)"))
    end

    cur_value *= cur_scalar

    cur_reactor = nothing

    cur_keys = collect(keys(secondary_limits))

    filter!(cur_key -> !in(cur_key, tmp_reactor.skipped_limits), cur_keys)
    filter!(cur_key -> !in(cur_key, tmp_reactor.ignored_limits), cur_keys)

    filter!(cur_key -> cur_key != tmp_reactor.constraint, cur_keys)
    unshift!(cur_keys, tmp_reactor.constraint)

    for cur_key in cur_keys
      work_reactor = deepcopy(tmp_reactor)
      work_reactor.constraint = cur_key

      if tmp_reactor.is_consistent
        work_reactor = hone(work_reactor, cur_field, cur_value)
      else
        work_reactor = match(work_reactor, cur_field, cur_value)
      end

      ( work_reactor == nothing ) && continue
      work_reactor.is_valid || continue
      cur_reactor = work_reactor
      break
    end

    if cur_reactor == nothing
      for cur_key in cur_keys
        work_reactor = deepcopy(tmp_reactor)
        work_reactor.constraint = cur_key

        if tmp_reactor.is_consistent
          work_reactor = hone(work_reactor, cur_field, cur_value)
        else
          work_reactor = match(work_reactor, cur_field, cur_value)
        end

        ( work_reactor == nothing ) && continue

        cur_reactor = work_reactor
        break
      end
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
    @showprogress [cur_func(tmp_index) for tmp_index in shuffle(1:num_points)]
  end

  if cur_scalar == 1.0
    cur_prefix = "mid"
  elseif cur_scalar < 1
    cur_prefix = "bot"
  else
    cur_prefix = "top"
  end

  cur_reactors = getfield(cur_study, Symbol("$(cur_prefix)_$(cur_field)_reactors"))

  _make_study_reactors!(cur_reactors, cur_parameter, parameter_list, cur_dict, cur_array)
end

function _make_cost_study_reactors(cur_study, cur_parameter, parameter_list, cur_dict, num_points, verbose, is_parallel)
  cur_array = SharedArray{Float64}(num_points, 3)
  fill!(cur_array, NaN)

  cur_func = function (cur_index::Integer)
    tmp_dict = deepcopy(cur_dict)
    tmp_dict[cur_parameter] = parameter_list[cur_index]

    tmp_reactor = Reactor(symbols(:T_bar), tmp_dict)

    cur_kink_reactor_index = findfirst(
      tmp_kink_reactor -> getfield(tmp_kink_reactor, cur_parameter) == parameter_list[cur_index],
      cur_study.kink_reactors
    )

    cur_wall_reactor_index = findfirst(
      tmp_wall_reactor -> getfield(tmp_wall_reactor, cur_parameter) == parameter_list[cur_index],
      cur_study.wall_reactors
    )

    cur_min_T = min_T_bar
    cur_max_T = max_T_bar

    if !iszero(cur_kink_reactor_index) && !iszero(cur_wall_reactor_index)
      cur_kink_reactor = cur_study.kink_reactors[cur_kink_reactor_index]
      cur_wall_reactor = cur_study.wall_reactors[cur_wall_reactor_index]

      cur_min_T = min(cur_kink_reactor.T_bar, cur_wall_reactor.T_bar)
      cur_max_T = max(cur_kink_reactor.T_bar, cur_wall_reactor.T_bar)
    elseif !iszero(cur_kink_reactor_index) || !iszero(cur_wall_reactor_index)
      if !iszero(cur_kink_reactor_index)
        cur_limit_reactor = cur_study.kink_reactors[cur_kink_reactor_index]
      else
        cur_limit_reactor = cur_study.wall_reactors[cur_wall_reactor_index]
      end

      if cur_limit_reactor.is_valid
        tmp_func = cost_minimization(tmp_reactor)
        cur_min_T = find_valid_range(tmp_func, cur_min_T, cur_limit_reactor.T_bar; fb=cur_limit_reactor.cost, no_pts=26, atol=1e-4, rtol=3e-3)[1]
        cur_max_T = find_valid_range(tmp_func, cur_limit_reactor.T_bar, cur_max_T; fa=cur_limit_reactor.cost, no_pts=26, atol=1e-4, rtol=3e-3)[2]
      end
    end

    cur_cost_reactor = find_min_cost_reactor(tmp_reactor, cur_min_T, cur_max_T)
    ( cur_cost_reactor == nothing ) && return

    cur_array[cur_index,1] = cur_cost_reactor.T_bar
    cur_array[cur_index,2] = cur_cost_reactor.I_P
    cur_array[cur_index,3] = cur_cost_reactor.eta_CD
  end

  if is_parallel
    if verbose
      cur_progress = Progress(num_points)
      pmap(cur_func, cur_progress, shuffle(1:num_points))
    else
      pmap(cur_func, shuffle(1:num_points))
    end
  else
    @showprogress [cur_func(tmp_index) for tmp_index in shuffle(1:num_points)]
  end

  _make_study_reactors!(cur_study.cost_reactors, cur_parameter, parameter_list, cur_dict, cur_array)
end

function _make_study_reactors!(cur_reactors, cur_parameter, parameter_list, cur_dict, cur_array)
  for (cur_index, cur_value) in enumerate(parameter_list)
    cur_T_bar, cur_I_P, cur_eta_CD = cur_array[cur_index,:]

    isnan(cur_eta_CD) && continue
    isnan(cur_T_bar) && continue
    isnan(cur_I_P) && continue

    tmp_dict = deepcopy(cur_dict)
    tmp_dict[cur_parameter] = parameter_list[cur_index]

    work_reactor = Reactor(cur_T_bar, tmp_dict)
    work_reactor.I_P = cur_I_P
    work_reactor.eta_CD = cur_eta_CD

    push!(cur_reactors, update!(work_reactor))
  end
end
