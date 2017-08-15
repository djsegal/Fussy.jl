"""
    solved_T_k_from_wall(T_guess, cur_B_0=( B_0 / 1u"T" ), cur_eta_CD=default_eta_CD; verbose=true)

Lorem ipsum dolor sit amet.
"""
function solved_T_k_from_wall(T_guess, cur_B_0=( B_0 / 1u"T" ), cur_eta_CD=default_eta_CD; verbose=true)

  cur_eq_exp = power_balance_r_exp()

  cur_eq = K_3() * G_3()

  cur_eq ^= ( cur_eq_exp / 3.0 )

  cur_eq /= K_1() * G_1()

  cur_eq /= cur_B_0 ^ ( alphas["B_0"] )

  cur_eq -= 1.0

  solved_T_k = solved_T_k_from_constraint(T_guess, cur_eta_CD, cur_eq, verbose)

  solved_T_k

end
