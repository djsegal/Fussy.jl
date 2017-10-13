"""
    solve_given_equation(main_value, given_equations, side_guess=15.0; verbose=false, eta_CD_guess=eta_CD)

Lorem ipsum dolor sit amet.
"""
function solve_given_equation(main_value, given_equations, side_guess=15.0; verbose=false, eta_CD_guess=eta_CD)
  solved_equation = OrderedDict()
  solved_equation["limits"] = OrderedDict()

  cur_solved_steady_density = solved_steady_density() / 1u"n20"
  cur_solved_steady_current = solved_steady_current() / 1u"MA"

  eta_CD_attempt_list = Array{AbstractFloat}([eta_CD_guess])

  if enable_eta_CD_derive
    for cur_scaling = (0.0:eta_CD_attempt_count-1)/2 + 1.25
      push!(eta_CD_attempt_list, eta_CD_guess * cur_scaling)
      push!(eta_CD_attempt_list, eta_CD_guess / cur_scaling)
    end
  end

  cur_solved_R_0 = NaN
  cur_solved_B_0 = NaN
  cur_solved_T_k = NaN

  cur_eta_CD = NaN
  cur_rho_j = NaN

  is_success = false

  for sub_key in keys(constraint_params)
    solved_equation["limits"][sub_key] = NaN
  end

  iszero(main_value) && ( eta_CD_attempt_list = [] )

  for cur_eta_CD_attempt in eta_CD_attempt_list
    cur_solved_R_0, cur_solved_B_0, cur_solved_T_k, cur_eta_CD, cur_rho_j =
      converge_eta_CD(main_value, given_equations, cur_eta_CD_attempt, side_guess, verbose=verbose)

    if !isnan(cur_eta_CD)
      is_success = true
      break
    end

    verbose && print("~")
  end

  solved_equation["success"] = is_success

  solved_equation["eta_CD"] = cur_eta_CD
  solved_equation["rho_j"] = cur_rho_j

  solved_equation["R_0"] = cur_solved_R_0
  solved_equation["B_0"] = cur_solved_B_0
  solved_equation["T_k"] = cur_solved_T_k

  !is_success && ( return solved_equation )
  iszero(main_value) && ( return solved_equation )
  isnan(cur_solved_T_k) && ( return solved_equation )

  for (cur_index, (sub_key, sub_value)) in enumerate(constraint_params)
    cur_limit_eq = subs(
      getfield( Tokamak, Symbol("R_B_$(cur_index)") )(),
      symbol_dict["R_0"] => cur_solved_R_0,
      symbol_dict["B_0"] => cur_solved_B_0
    )

    cur_limit_eq -= (
      symbol_dict["G_K_$(cur_index)"] *
      getfield( Tokamak, Symbol("K_$(cur_index)") )()
    )

    tmp_value = first(elements(solveset(
      cur_limit_eq,
      symbol_dict[sub_value],
      SymPy.S.Reals
    )))

    tmp_value = subs(
      tmp_value,
      symbol_dict["G_K_$(cur_index)"],
      getfield( Tokamak, Symbol("G_$(cur_index)") )()
    )

    tmp_value /= eval(parse("max_$(sub_value)"))

    isnan(tmp_value) && continue

    tmp_value = calc_possible_values(
      tmp_value,
      cur_T_k=cur_solved_T_k*1u"keV",
      cur_eta_CD=cur_eta_CD
    )

    tmp_value = subs(tmp_value,
      symbol_dict["n_bar"] => cur_solved_steady_density,
      symbol_dict["I_M"] => cur_solved_steady_current,
      symbol_dict["R_0"] => cur_solved_R_0,
      symbol_dict["B_0"] => cur_solved_B_0,
      symbol_dict["T_k"] => cur_solved_T_k
    )

    solved_equation["limits"][sub_key] = tmp_value
  end

  solved_equation
end
