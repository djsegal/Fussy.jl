"""
    run_monte_carlo(cur_T, run_count, swept_params...; cur_sensitivity=0.2, sensitive_variables=[], verbose=true)

Lorem ipsum dolor sit amet.
"""
function run_monte_carlo(cur_T, run_count, swept_params...; cur_sensitivity=0.2, sensitive_variables=[], verbose=true)
  cur_output = Array{Any}(run_count)

  sensitive_params = OrderedDict()

  for cur_param in sensitive_variables
    if cur_param == "T_k"
      sensitive_params[cur_param] = cur_T
      continue
    end

    sensitive_params[cur_param] = getfield( Fusion, Symbol(cur_param) )
  end

  for cur_index in 1:run_count
    if verbose ; print(".") ; end

    loaded_input = ""

    for (cur_param, cur_range) in swept_params
      cur_diff = first(diff(cur_range))

      cur_value = rand()
      cur_value *= cur_diff
      cur_value += first(cur_range)

      loaded_input *= "$(cur_param) = $(cur_value);"
    end

    for (cur_param, cur_value) in sensitive_params
      cur_delta = cur_sensitivity * cur_value
      cur_scale = 2 * rand() - 1.0

      mutated_value = cur_value
      mutated_value += cur_scale * cur_delta

      if cur_param == "T_k"
        cur_T = mutated_value
        continue
      end

      loaded_input *= "$(cur_param) = $(mutated_value);"
    end

    Fusion.load_input(loaded_input)

    cur_sweep = sweep_T_k([cur_T]; verbose=false)

    for (cur_key, cur_value) in cur_sweep
      if eltype(cur_value) == Pair{Any,Any}
        for (cur_sub_key, cur_sub_value) in cur_value
          cur_sweep[cur_key][cur_sub_key] = first(cur_sub_value)
        end

        continue
      end

      cur_sweep[cur_key] = first(cur_value)
    end

    cur_output[cur_index] = Fusion.analyze_solved_case(cur_sweep)
  end

  cur_output
end
