"""
    solved_R_0_from_power_balance(cur_T_k, cur_B_0=( B_0 / 1u"T" ))

Lorem ipsum dolor sit amet.
"""
function solved_R_0_from_power_balance(cur_T_k, cur_B_0=( B_0 / 1u"T" ))

  solved_R_0 = -K_nu()
  solved_R_0 *= cur_T_k ^ 0.5
  solved_R_0 += ( sigma_v_hat / 1u"m^3/s" )

  solved_R_0 *= -K_PB_legacy()
  solved_R_0 *= cur_B_0 ^ 0.15

  solved_R_0 /= cur_T_k ^ 0.04
  solved_R_0 /= ( sigma_v_hat / 1u"m^3/s" ) ^ 0.69
  solved_R_0 /= K_CD_denom ^ 0.96

  solved_R_0 ^= 6.25

  solved_R_0 = calc_possible_values( solved_R_0 )

  solved_R_0 = subs(solved_R_0, Tokamak.symbol_dict["T_k"], cur_T_k)

  solved_R_0 *= 1u"m"

  solved_R_0

end
