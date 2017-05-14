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
    solved_equation[key] = OrderedDict(
      "other_limits" => OrderedDict()
    )
  end

  for (eq_index, (key, value)) in enumerate(given_equations)
    cur_solved_R_0 = given_equations[key]["R_0"]() / 1u"m"
    cur_solved_B_0 = given_equations[key]["B_0"]() / 1u"T"

    if !has_complex_value[eq_index] && !isreal(cur_solved_R_0)
      has_complex_value[eq_index] = true
      println("Complex R_0 detected")
    end

    if has_complex_value[eq_index]
      cur_solved_R_0 = Inf
      cur_solved_B_0 = 0
    end

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
