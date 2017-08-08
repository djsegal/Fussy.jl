"""
    sweep_B_0(B_list, T_guess=15.0; verbose=true)

Lorem ipsum dolor sit amet.
"""
function sweep_B_0(B_list, T_guess=15.0; verbose=true)

  given_equations = setup_given_equations()

  load_input( "beta_N = $(max_beta_N)" )
  load_input( "P_W = $( max_P_W ) * ( 1u\"MW\" / 1u\"m^2\" )" )

  solved_equations = OrderedDict()

  solved_equations["R_0"] = Array{Float64}(length(B_list))
  solved_equations["B_0"] = Array{Float64}(length(B_list))
  solved_equations["T_k"] = Array{Float64}(length(B_list))

  solved_equations["eta_CD"] = Array{Float64}(length(B_list))

  solved_equations["constraint"] = Array{AbstractString}(length(B_list))

  solved_equations["limits"] = OrderedDict()

  for cur_key in keys(given_equations)
    solved_equations["limits"][cur_key] = Array{Float64}(length(B_list))
  end

  cur_constraint = "beta"
  cur_eta_CD = default_eta_CD

  for cur_index = 1:length(B_list)
    cur_B = B_list[cur_index]
    if verbose ; print("\n\n$cur_B\n") ; end

    cur_solved_equation = solve_given_equation(cur_B, given_equations, T_guess, verbose=verbose, cur_constraint=cur_constraint, cur_eta_CD=cur_eta_CD)

    new_constraint = collect(keys(cur_solved_equation["limits"]))[indmax(collect(values(cur_solved_equation["limits"])))]

    if new_constraint != cur_constraint
      cur_constraint = new_constraint

      cur_solved_equation = solve_given_equation(cur_B, given_equations, T_guess, verbose=verbose, cur_constraint=cur_constraint, cur_eta_CD=cur_eta_CD)

      new_constraint = collect(keys(cur_solved_equation["limits"]))[indmax(collect(values(cur_solved_equation["limits"])))]
    end

    if new_constraint != cur_constraint
      println("Unable to satisfy all constraints")

      cur_solved_equation["R_0"] = NaN
      cur_solved_equation["T_k"] = NaN
      cur_solved_equation["eta_CD"] = NaN
    end

    solved_equations["constraint"][cur_index] = cur_constraint

    solved_equations["R_0"][cur_index] = cur_solved_equation["R_0"]
    solved_equations["B_0"][cur_index] = cur_solved_equation["B_0"]
    solved_equations["T_k"][cur_index] = cur_solved_equation["T_k"]

    solved_equations["eta_CD"][cur_index] = cur_solved_equation["eta_CD"]

    for (sub_key, sub_value) in given_equations
      solved_equations["limits"][sub_key][cur_index] = cur_solved_equation["limits"][sub_key]
    end

    is_successful_run = !isnan(solved_equations["T_k"][cur_index])

    if is_successful_run
      T_guess = solved_equations["T_k"][cur_index]
      cur_eta_CD = solved_equations["eta_CD"][cur_index]
    end
  end

  return solved_equations

end
