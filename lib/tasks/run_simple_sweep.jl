"""
    run_simple_sweep(cur_T_k, swept_param; verbose=true)

Lorem ipsum dolor sit amet.
"""
function run_simple_sweep(cur_T_k, swept_param=("control" => true); verbose=true)
  cur_sweep = run_parameter_sweep([cur_T_k], swept_param)

  cur_output = []

  for (cur_key, cur_sub_sweep) in cur_sweep
    Tokamak.load_input(cur_key)

    clean_sweep = first(Tokamak.restructure_sweep(cur_sub_sweep))

    cur_case = Tokamak.analyze_solved_case(clean_sweep)

    push!(cur_output, cur_case)
  end

  cur_output
end
