"""
    run_parameter_sweep(B_list, swept_params...; T_guess=15.0, verbose=true)

Lorem ipsum dolor sit amet.
"""
function run_parameter_sweep(B_list, swept_params...; T_guess=15.0, verbose=true)
  if isempty(swept_params)
    return sweep_B_0(B_list, T_guess; verbose=verbose)
  end

  cur_variable, cur_range = first(swept_params)

  cur_output = OrderedDict()

  for cur_value in cur_range
    if isa(cur_value, AbstractString)
      cur_value = "\"$cur_value\""
    end

    cur_input = "$cur_variable = $cur_value"

    if verbose ; println(" \n\n $cur_input \n ") ; end

    Tokamak.load_input(cur_input)

    cur_output[cur_input] = run_parameter_sweep(B_list, swept_params[2:end]...)
  end

  cur_output
end
