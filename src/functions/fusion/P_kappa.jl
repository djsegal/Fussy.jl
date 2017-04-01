"""
    P_kappa()

Lorem ipsum dolor sit amet.
"""
function P_kappa()
  cur_P_kappa = K_kappa()

  cur_P_kappa *= ( R_0 / 1u"m" ) ^ 3
  cur_P_kappa *= ( n_bar / 1u"n20" )
  cur_P_kappa *= ( T_k / 1u"keV" )

  cur_P_kappa /= ( tau_E / 1u"s" )

  cur_P_kappa *= 1u"MW"

  cur_P_kappa
end
