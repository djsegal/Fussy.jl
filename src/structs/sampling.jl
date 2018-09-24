mutable struct Sampling <: AbstractSampling
  parameters::Vector{Symbol}

  sensitivity::Real

  study_count::Int

  deck::Union{Void, Symbol}

  defaults::Vector{Real}

  kink_reactors::Vector{AbstractNullableReactor}
  wall_reactors::Vector{AbstractNullableReactor}

  cost_reactors::Vector{AbstractNullableReactor}
  W_M_reactors::Vector{AbstractNullableReactor}
end

function Sampling(parameters::Vector{Symbol}; sensitivity::Real=0.35, study_count::Int=100, deck::Union{Void, Symbol}=nothing, is_parallel::Bool=true, cur_kwargs...)
  cur_dict = merge!(Dict(), Dict(cur_kwargs))
  cur_dict[:constraint] = :beta
  cur_dict[:deck] = deck

  cur_reactor_types = [:kink, :wall, :cost,  :W_M]

  defaults = []
  ranges = OrderedDict()

  reactors_per_study = 4

  work_reactor = Reactor(symbols(:T_bar), cur_dict)

  for cur_parameter in parameters
    cur_med_value = getfield(work_reactor, cur_parameter)
    push!(defaults, cur_med_value)

    cur_min_value = cur_med_value * ( 1 - sensitivity )
    cur_max_value = cur_med_value * ( 1 + sensitivity )
    ranges[cur_parameter] = (cur_min_value, cur_max_value)
  end

  cur_sampling = Sampling(
    parameters, sensitivity, study_count, deck, defaults,
    [ fill!(Vector(study_count), nothing) for cur_index in 1:reactors_per_study]...
  )

  @assert !haskey(ranges, :T_bar)

  cur_constraints = SharedArray{Int}(study_count, reactors_per_study)

  cur_array = SharedArray{Float64}(study_count, reactors_per_study, 3+length(ranges))
  fill!(cur_array, NaN)

  cur_func = function (cur_index::Integer)
    tmp_dict = deepcopy(cur_dict)

    tmp_array = Vector{Float64}(length(ranges))

    for (cur_sub_index, (cur_key, cur_value)) in enumerate(ranges)
      if isa(cur_value, Tuple)
        if length(unique(cur_value)) == 1
          tmp_value = cur_value[1]
        else
          tmp_value = rand(Uniform(cur_value...))
        end
      elseif isa(cur_value, AbstractArray)
        tmp_value = pluck(cur_value)
      elseif isa(cur_value, Number)
        tmp_value = cur_value
      else
        error("Invalid sampling range for: $(cur_key)")
      end

      tmp_array[cur_sub_index] = tmp_value
      tmp_dict[cur_key] = tmp_value
    end

    tmp_reactor = Reactor(symbols(:T_bar), tmp_dict)

    tmp_reactor.is_good || return

    tmp_study = Study(:H, tmp_dict; num_points=1, verbose=false, is_parallel=false)

    for (cur_sub_index, cur_reactor_type) in enumerate(cur_reactor_types)
      tmp_sub_reactors = getfield(tmp_study, Symbol("$(cur_reactor_type)_reactors"))
      isempty(tmp_sub_reactors) && continue

      @assert length(tmp_sub_reactors) == 1
      tmp_sub_reactor = tmp_sub_reactors[1]

      tmp_sub_array = [
        tmp_sub_reactor.T_bar,
        tmp_sub_reactor.I_P,
        tmp_sub_reactor.eta_CD
      ]

      cur_array[cur_index, cur_sub_index, :] = [ tmp_sub_array..., tmp_array... ]
      cur_constraints[cur_index, cur_sub_index] =
        findfirst(tmp_constraint -> tmp_constraint == tmp_sub_reactor.constraint, collect(keys(secondary_limits)))
    end

    return
  end

  if is_parallel
    cur_progress = Progress(study_count)
    pmap(cur_func, cur_progress, shuffle(1:study_count))
  else
    map(cur_func, 1:study_count)
  end

  for cur_index in 1:study_count
    for (cur_sub_index, cur_reactor_type) in enumerate(cur_reactor_types)
      any(isnan, cur_array[cur_index,cur_sub_index,:]) && continue

      cur_T_bar, cur_I_P, cur_eta_CD = cur_array[cur_index,cur_sub_index,1:3]

      tmp_dict = deepcopy(cur_dict)

      for (cur_sub_sub_index, cur_range_name) in enumerate(keys(ranges))
        tmp_dict[cur_range_name] = cur_array[cur_index, cur_sub_index, cur_sub_sub_index+3]
      end

      tmp_dict[:constraint] = collect(keys(secondary_limits))[cur_constraints[cur_index,cur_sub_index]]

      work_reactor = Reactor(cur_T_bar, tmp_dict)
      work_reactor.I_P = cur_I_P
      work_reactor.eta_CD = cur_eta_CD

      work_reactors = getfield(cur_sampling, Symbol("$(cur_reactor_type)_reactors"))
      work_reactors[cur_index] = update!(work_reactor)
    end
  end

  cur_sampling
end
