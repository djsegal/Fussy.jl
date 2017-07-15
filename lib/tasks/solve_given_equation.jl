"""
    solve_given_equation(cur_B, given_equations, T_guess=15.0; verbose=false, cur_constraint="beta")

Lorem ipsum dolor sit amet.
"""
function solve_given_equation(cur_B, given_equations, T_guess=15.0; verbose=false, cur_constraint="beta")
  solved_equation = OrderedDict()
  solved_equation["other_limits"] = OrderedDict()

  initial_eta_CD = eta_CD

  cur_solved_steady_density = solved_steady_density() / 1u"n20"
  cur_solved_steady_current = solved_steady_current() / 1u"MA"

  cur_solved_R_0, cur_solved_T_k, cur_eta_CD = converge_eta_CD(cur_B, given_equations[cur_constraint], T_guess, verbose=verbose)

  solved_equation["eta_CD"] = cur_eta_CD

  solved_equation["R_0"] = cur_solved_R_0
  solved_equation["B_0"] = cur_B
  solved_equation["T_k"] = cur_solved_T_k

  load_input("eta_CD = $initial_eta_CD")

  for (sub_key, sub_value) in given_equations
    tmp_value = sub_value["cur_limit"]
    tmp_value /= sub_value["max_limit"]

    if isnan(cur_solved_T_k) || isnan(tmp_value)
      solved_equation["other_limits"][sub_key] = NaN
      continue
    end

    tmp_value = calc_possible_values(tmp_value, cur_T_k=cur_solved_T_k*1u"keV")

    tmp_value = subs(tmp_value,
      symbol_dict["n_bar"] => cur_solved_steady_density,
      symbol_dict["I_M"] => cur_solved_steady_current,
      symbol_dict["R_0"] => cur_solved_R_0,
      symbol_dict["T_k"] => cur_solved_T_k,
      symbol_dict["B_0"] => cur_B
    )

    solved_equation["other_limits"][sub_key] = tmp_value
  end

  solved_equation
end
