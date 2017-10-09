"""
    run_monte_carlo(T_list, run_count, swept_params...; verbose=true)

Lorem ipsum dolor sit amet.
"""
function run_monte_carlo(T_list, run_count, swept_params...; verbose=true)
  if isempty(swept_params)
    error("Monte Carlo requires swept variables")
  end

  cur_variable, cur_range = first(swept_params)

  cur_output = Array{Any}(run_count)

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

    Tokamak.load_input(loaded_input)

    cur_sweep = sweep_T_k(T_list; verbose=false)

    for (cur_key, cur_value) in cur_sweep
      if eltype(cur_value) == Pair{Any,Any}
        for (cur_sub_key, cur_sub_value) in cur_value
          cur_sweep[cur_key][cur_sub_key] = first(cur_sub_value)
        end

        continue
      end

      cur_sweep[cur_key] = first(cur_value)
    end

    cur_output[cur_index] = Tokamak.analyze_solved_case(cur_sweep)
  end

  cur_output
end
