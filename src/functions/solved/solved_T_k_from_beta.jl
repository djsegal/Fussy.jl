"""
    solved_T_k_from_beta(T_guess, cur_B_0=( B_0 / 1u"T" ))

Lorem ipsum dolor sit amet.
"""
function solved_T_k_from_beta(T_guess, cur_B_0=( B_0 / 1u"T" ))

  cur_eq = -K_BR()
  cur_eq *= ( T_k / 1u"keV" ) ^ 0.5
  cur_eq += ( sigma_v_hat / 1u"m^3/s" )

  cur_eq = 1 / cur_eq

  cur_eq /= -K_PB()

  cur_eq *= ( T_k / 1u"keV" ) ^ 0.04
  cur_eq *= ( sigma_v_hat / 1u"m^3/s" ) ^ 0.69
  cur_eq *= K_CD_denom ^ 0.96

  cur_eq *= ( K_beta() * ( T_k / 1u"keV" ) ) ^ 0.16

  cur_eq ^= 3.225806452

  cur_eq -= cur_B_0

  cur_eq = calc_possible_values( cur_eq )

  try
    solved_T_k = nsolve(cur_eq, T_guess)
  catch
    solved_T_k = NaN
  end

  solved_T_k *= 1u"keV"

  solved_T_k

end
