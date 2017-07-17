"""
    solved_R_0_from_T_k(cur_T_k, cur_B_0=( B_0 / 1u"T" ), cur_eta_CD=default_eta_CD)

Lorem ipsum dolor sit amet.
"""
function solved_R_0_from_T_k(cur_T_k, cur_B_0=( B_0 / 1u"T" ), cur_eta_CD=default_eta_CD)

  if isnan( cur_T_k )
    return NaN * 1u"m"
  end

  solved_R_0 = K_1()

  solved_R_0 *= G_1()

  solved_R_0 *= cur_B_0 ^ alphas["B_0"]

  solved_R_0 ^= ( 1 / power_balance_r_exp() )

  solved_R_0 = calc_possible_values(
    solved_R_0 , cur_T_k = ( cur_T_k * 1u"keV" ), cur_eta_CD=cur_eta_CD
  )

  solved_R_0 *= 1u"m"

  solved_R_0

end
