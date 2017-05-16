"""
    solve_equation_set(cur_T, given_equations)

Lorem ipsum dolor sit amet.
"""
function solve_equation_set(cur_T, given_equations)
  load_input( "T_k = $(cur_T)u\"keV\"" )

  cur_n_bar = symbol_dict["n_bar"]
  cur_I_M = symbol_dict["I_M"]

  cur_R_0 = symbol_dict["R_0"]
  cur_B_0 = symbol_dict["B_0"]

  solved_equation = OrderedDict()

  for key in keys(given_equations)
    solved_equation[key] = OrderedDict()
    solved_equation[key]["other_limits"] = OrderedDict()
  end

  cur_solved_steady_density = solved_steady_density() / 1u"n20"
  cur_solved_steady_current = solved_steady_current() / 1u"MA"

  initial_eta_CD = eta_CD

  for (eq_index, (key, value)) in enumerate(given_equations)

    println(" \n\n $key \n ")

    cur_solved_R_0, cur_solved_B_0, cur_eta_CD = converge_eta_CD(given_equations[key])

    solved_equation[key]["eta_CD"] = cur_eta_CD

    load_input("eta_CD = $initial_eta_CD")

    solved_equation[key]["R_0"] = cur_solved_R_0
    solved_equation[key]["B_0"] = cur_solved_B_0

    for (sub_key, sub_value) in given_equations
      tmp_value = sub_value["cur_limit"]

      tmp_value = subs(tmp_value,
        cur_n_bar => cur_solved_steady_density,
        cur_I_M => cur_solved_steady_current,
        cur_R_0 => cur_solved_R_0,
        cur_B_0 => cur_solved_B_0
      )

      tmp_value = calc_possible_values(tmp_value)

      tmp_value /= sub_value["max_limit"]

      solved_equation[key]["other_limits"][sub_key] = tmp_value
    end

  end

  solved_equation
end
