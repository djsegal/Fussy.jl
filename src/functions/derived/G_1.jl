"""
    G_1()

Lorem ipsum dolor sit amet.
"""
function G_1()
  cur_G_1 = -K_nu()

  cur_G_1 *= ( T_k / 1u"keV" ) ^ 0.5

  cur_G_1 += ( sigma_v_hat / 1u"m^3/s" )

  cur_G_1 /= ( sigma_v_hat / 1u"m^3/s" ) ^ alphas["P"]

  cur_alpha_T = alpha_T()

  cur_G_1 /= ( T_k / 1u"keV" ) ^ cur_alpha_T

  cur_G_1 /= K_CD_denom ^ ( 1 - cur_alpha_T )

  cur_G_1
end
