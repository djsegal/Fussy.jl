"""
    solve_equation_set(cur_B, given_equations, T_guess=15.0; verbose=false)

Lorem ipsum dolor sit amet.
"""
function solve_equation_set(cur_B, given_equations, T_guess=15.0; verbose=false)
  solved_equations = OrderedDict()

  for key in keys(given_equations)

    if verbose ; println(" \n\n $key \n ") ; end

    solved_equations[key] = solve_given_equation(cur_B, given_equations, T_guess, verbose=verbose, cur_constraint=key)

    cur_solved_T_k = solved_equations[key]["T_k"]

    if !isnan(cur_solved_T_k)
      T_guess = cur_solved_T_k
    end

  end

  solved_equations
end
