"""
    solved_T_k_from_wall(T_guess, cur_B_0=( B_0 / 1u"T" ), cur_eta_CD=default_eta_CD; verbose=true)

Lorem ipsum dolor sit amet.
"""
function solved_T_k_from_wall(T_guess, cur_B_0=( B_0 / 1u"T" ), cur_eta_CD=default_eta_CD; verbose=true)

  cur_eq_exp = power_balance_r_exp()

  cur_eq = K_3() * G_3()

  cur_eq ^= ( cur_eq_exp / 3.0 )

  cur_eq /= K_1() * G_1()

  cur_eq -= cur_B_0 ^ ( alphas["B_0"] )

  attempt_list = Array{AbstractFloat}([T_guess])

  for cur_scaling = 2.0:4.0
    push!(attempt_list, T_guess * cur_scaling)
    push!(attempt_list, T_guess / cur_scaling)
  end

  solved_T_k = NaN

  for cur_attempt in attempt_list
    did_work = true

    try
      solved_T_k = nlsolve(
        @generate_fusion_equation_set(cur_eq, cur_eta_CD), [cur_attempt],
        show_trace = false, iterations=100
      ).zero[1]

      cur_F = calc_possible_values(cur_eq, cur_T_k=solved_T_k*1u"keV")

      if abs(cur_F) > 1e-4
        did_work = false
        solved_T_k = NaN
        continue
      end
    catch DomainError
      did_work = false
    end

    if !did_work ; continue ; end

    if verbose ; print("✓") ; end
    break
  end

  solved_T_k *= 1u"keV"

  solved_T_k

end
