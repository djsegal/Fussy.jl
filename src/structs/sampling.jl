mutable struct Sampling <: AbstractSampling
  parameters::Vector{Symbol}

  sensitivity::Real

  run_count::Int
  max_reactors::Int

  deck::Union{Void, Symbol}

  defaults::Vector{Real}
  reactors::Vector{AbstractReactor}
end

function Sampling(parameters::Vector{Symbol}; sensitivity::Real=1.0, run_count::Int=100, max_reactors::Int=25, deck::Union{Void, Symbol}=nothing, batch_count::Int=5, max_time::Number=NaN, cur_kwargs...)
  cur_dict = merge!(Dict(), Dict(cur_kwargs))
  cur_dict[:constraint] = :beta
  cur_dict[:deck] = deck

  defaults = []
  ranges = OrderedDict()

  work_reactor = Reactor(symbols(:T_bar), cur_dict)

  for cur_parameter in parameters
    cur_med_value = getfield(work_reactor, cur_parameter)
    push!(defaults, cur_med_value)

    cur_min_value = cur_med_value * ( 1 - sensitivity )
    cur_max_value = cur_med_value * ( 1 + sensitivity )
    ranges[cur_parameter] = (cur_min_value, cur_max_value)
  end

  cur_sampling = Sampling(
    parameters, sensitivity, run_count, max_reactors, deck, defaults, []
  )

  @assert !haskey(ranges, :T_bar)

  cur_array = SharedArray{Float64}(max_reactors, 4+length(ranges))
  fill!(cur_array, NaN)

  cur_func = function (cur_index::Integer)
    tmp_dict = deepcopy(cur_dict)

    tmp_array = Vector{Float64}(4+length(ranges))

    for (cur_sub_index, (cur_key, cur_value)) in enumerate(ranges)
      if isa(cur_value, Tuple)
        tmp_value = rand(Uniform(cur_value...))
      elseif isa(cur_value, AbstractArray)
        tmp_value = pluck(cur_value)
      elseif isa(cur_value, Number)
        tmp_value = cur_value
      else
        error("Invalid sampling range for: $(cur_key)")
      end

      tmp_array[4+cur_sub_index] = tmp_value
      tmp_dict[cur_key] = tmp_value
    end

    tmp_reactor = Reactor(symbols(:T_bar), tmp_dict)

    tmp_reactor.is_good || return

    for cur_limit in [:wall, :kink]
      cur_reactor = nothing

      if tmp_reactor.is_consistent
        cur_reactor = hone(tmp_reactor, cur_limit)
      else
        cur_reactor = match(tmp_reactor, cur_limit)
      end

      ( cur_reactor == nothing ) && continue
      ( cur_reactor.is_valid ) || continue

      tmp_array[1] = cur_reactor.T_bar
      tmp_array[2] = cur_reactor.I_P
      tmp_array[3] = cur_reactor.eta_CD
      tmp_array[4] = cur_reactor.cost

      needs_continue = false

      cur_min = cur_reactor.cost
      for cur_attempt in 1:5
        cur_sub_index = pluck(1:max_reactors)
        other_min = cur_array[cur_sub_index, 4]

        ( isnan(other_min) || cur_min < other_min ) || continue

        cur_array[cur_sub_index,:] = tmp_array
        needs_continue = true
        break
      end

      needs_continue && continue

      cur_nan_list = find(isnan, cur_array[:,4])
      if !isempty(cur_nan_list)
        cur_sub_index = pluck(cur_nan_list)
        cur_array[cur_sub_index,:] = tmp_array
        continue
      end

      cur_min_list = find(
        other_min -> ( cur_min < other_min ),
        cur_array[:,4]
      )

      isempty(cur_min_list) && continue
      cur_sub_index = pluck(cur_min_list)
      cur_array[cur_sub_index,:] = tmp_array
    end

    return
  end

  run_per_batch = Int(floor( run_count / batch_count ))
  extra_run_count = ( run_count - batch_count * run_per_batch )

  cur_pmap_complete = SharedArray{Bool}(batch_count)

  for cur_batch in 1:batch_count
    cur_run_count = run_per_batch
    ( cur_batch <= extra_run_count ) && ( cur_run_count += 1 )

     if !isnan(max_time)
      @async begin
        sleep(max_time)
        cur_pmap_complete[cur_batch] || interrupt(workers())
      end
    end

    cur_progress = Progress(cur_run_count)

    try
      pmap(cur_func, cur_progress, 1:cur_run_count)
    catch cur_error
      isa(cur_error, RemoteException) || rethrow(cur_error)

      sleep(4)
      finish!(cur_progress)
    end

    cur_pmap_complete[cur_batch] = true
  end

  for cur_index in 1:max_reactors
    any(isnan, cur_array[cur_index,:]) && continue

    cur_T_bar, cur_I_P, cur_eta_CD = cur_array[cur_index,1:3]

    tmp_dict = deepcopy(cur_dict)

    for (cur_sub_index, cur_range_name) in enumerate(keys(ranges))
      tmp_dict[cur_range_name] = cur_array[cur_index, cur_sub_index+4]
    end

    work_reactor = Reactor(cur_T_bar, tmp_dict)
    work_reactor.I_P = cur_I_P
    work_reactor.eta_CD = cur_eta_CD

    push!(cur_sampling.reactors, update!(work_reactor))
  end

  cur_sampling
end
