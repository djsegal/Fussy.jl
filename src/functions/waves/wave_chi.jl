"""
    wave_chi(cur_rho)

Lorem ipsum dolor sit amet.
"""
function wave_chi(cur_rho)

  cur_omega_pe = subs(
    Plasmas.omega_pe() * 1u"s",
    Plasmas.symbol_dict["n_e"],
    Tokamak.n_profile(cur_rho)
  )

  cur_omega_ce = subs(
    Plasmas.omega_ce() * 1u"s",
    Plasmas.symbol_dict["B_0"],
    Tokamak.wave_B(cur_rho) / 1u"T"
  )

  cur_wave_chi = cur_omega_pe ^ 2

  cur_wave_chi /= cur_omega_ce ^ 2

  cur_wave_chi

end
