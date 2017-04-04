"""
    h_mode_confinement_time()

Lorem ipsum dolor sit amet.
"""
function h_mode_confinement_time()
  cur_tau_E = 0.145
  cur_tau_E *= H

  cur_tau_E *= ( I_M / 1u"MA" ) ^ ( 93 // 100 )
  cur_tau_E *= ( R_0 / 1u"m" ) ^ ( 139 // 100 )
  cur_tau_E *= ( a() / 1u"m" ) ^ ( 58 // 100 )

  cur_tau_E *= kappa ^ ( 78 // 100 )

  cur_tau_E *= ( n_bar / 1u"n20" ) ^ ( 41 // 100 )
  cur_tau_E *= ( B_0 / 1u"T" ) ^ ( 15 // 100 )

  cur_tau_E *= A ^ ( 19 // 100 )

  cur_tau_E /= ( power_sources() / 1u"MW" ) ^ ( 69 // 100 )

  cur_tau_E *= 1u"s"

  cur_tau_E
end
