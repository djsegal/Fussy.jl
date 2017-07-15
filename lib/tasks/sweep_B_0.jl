"""
    sweep_B_0(B_list, T_guess=15.0; verbose=true)

Lorem ipsum dolor sit amet.
"""
function sweep_B_0(B_list, T_guess=15.0; verbose=true)

  given_equations = setup_given_equations()

  load_input( "beta_N = $(max_beta_N)" )
  load_input( "P_W = $( max_P_W / ( 1u"MW" / 1u"m^2" ) ) * ( 1u\"MW\" / 1u\"m^2\" )" )
  load_input( "h_parallel = $( max_h_parallel / ( 1u"MW" / 1u"m^2" ) ) * ( 1u\"MW\" / 1u\"m^2\" )" )

  solved_equations = OrderedDict()

  for key in keys(given_equations)
    solved_equations[key] = OrderedDict()

    solved_equations[key]["R_0"] = Array{Float64}(length(B_list))
    solved_equations[key]["B_0"] = Array{Float64}(length(B_list))
    solved_equations[key]["T_k"] = Array{Float64}(length(B_list))

    solved_equations[key]["eta_CD"] = Array{Float64}(length(B_list))

    solved_equations[key]["other_limits"] = OrderedDict()

    for sub_key in keys(given_equations)
      solved_equations[key]["other_limits"][sub_key] = Array{Float64}(length(B_list))
    end
  end

  @inbounds for cur_index = 1:length(B_list)
    cur_B = B_list[cur_index]
    if verbose ; print("\n\n$cur_B") ; end

    cur_solved_equation = solve_equation_set(cur_B, given_equations, T_guess, verbose=verbose)

    for (eq_index, (key, value)) in enumerate(given_equations)
      solved_equations[key]["R_0"][cur_index] = cur_solved_equation[key]["R_0"]
      solved_equations[key]["B_0"][cur_index] = cur_solved_equation[key]["B_0"]
      solved_equations[key]["T_k"][cur_index] = cur_solved_equation[key]["T_k"]

      solved_equations[key]["eta_CD"][cur_index] = cur_solved_equation[key]["eta_CD"]

      for (sub_key, sub_value) in given_equations
        solved_equations[key]["other_limits"][sub_key][cur_index] = cur_solved_equation[key]["other_limits"][sub_key]
      end
    end

    if !isnan(solved_equations["beta"]["T_k"][cur_index])
      T_guess = solved_equations["beta"]["T_k"][cur_index]
    end
  end

  return solved_equations

end
