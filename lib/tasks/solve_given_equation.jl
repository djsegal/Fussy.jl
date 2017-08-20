"""
    solve_given_equation(cur_B, given_equations, T_guess=15.0; verbose=false, cur_constraint=default_constraint, cur_eta_CD=default_eta_CD)

Lorem ipsum dolor sit amet.
"""
function solve_given_equation(cur_B, given_equations, T_guess=15.0; verbose=false, cur_constraint=default_constraint, cur_eta_CD=default_eta_CD)
  solved_equation = OrderedDict()
  solved_equation["limits"] = OrderedDict()

  cur_solved_steady_density = solved_steady_density() / 1u"n20"
  cur_solved_steady_current = solved_steady_current() / 1u"MA"

  eta_CD_attempt_list = Array{AbstractFloat}([cur_eta_CD])

  if enable_eta_CD_derive
    for cur_scaling = (0:eta_CD_attempt_count-1)/2 + 1.25
      push!(eta_CD_attempt_list, cur_eta_CD * cur_scaling)
      push!(eta_CD_attempt_list, cur_eta_CD / cur_scaling)
    end
  end

  cur_solved_R_0 = NaN
  cur_solved_T_k = NaN
  cur_eta_CD = NaN
  cur_rho_j = NaN

  for cur_eta_CD_attempt in eta_CD_attempt_list
    cur_solved_R_0, cur_solved_T_k, cur_eta_CD, cur_rho_j = converge_eta_CD(cur_B, given_equations[cur_constraint], cur_eta_CD_attempt, T_guess, verbose=verbose)

    if !isnan(cur_eta_CD) ; break ; end
  end

  solved_equation["eta_CD"] = cur_eta_CD
  solved_equation["rho_j"] = cur_rho_j

  solved_equation["R_0"] = cur_solved_R_0
  solved_equation["B_0"] = cur_B
  solved_equation["T_k"] = cur_solved_T_k

  for (sub_key, sub_value) in given_equations
    tmp_value = sub_value["cur_limit"]
    tmp_value /= sub_value["max_limit"]

    if isnan(cur_solved_T_k) || isnan(tmp_value)
      solved_equation["limits"][sub_key] = NaN
      continue
    end

    tmp_value = calc_possible_values(
      tmp_value,
      cur_T_k=cur_solved_T_k*1u"keV",
      cur_eta_CD=cur_eta_CD
    )

    tmp_value = subs(tmp_value,
      symbol_dict["n_bar"] => cur_solved_steady_density,
      symbol_dict["I_M"] => cur_solved_steady_current,
      symbol_dict["R_0"] => cur_solved_R_0,
      symbol_dict["T_k"] => cur_solved_T_k,
      symbol_dict["B_0"] => cur_B
    )

    solved_equation["limits"][sub_key] = tmp_value
  end

  solved_equation
end
