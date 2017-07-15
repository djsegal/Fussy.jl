"""
    G_3()

Lorem ipsum dolor sit amet.
"""
function G_3()
  cur_G_3 = ( T_k / 1u"keV" )

  cur_G_3 /= K_CD_denom

  cur_G_3 ^= 2

  cur_G_3 *= ( sigma_v_hat / 1u"m^3/s" )

  cur_G_3
end
