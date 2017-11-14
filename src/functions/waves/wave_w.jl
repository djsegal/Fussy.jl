"""
    wave_w(cur_rho)

Lorem ipsum dolor sit amet.
"""
function wave_w(cur_rho)
  cur_w = Unitful.c0 / 1u"m/s"

  cur_w /= subs(
    Plasmas.v_Te() / 1u"m/s",
    Plasmas.symbol_dict["T_e"],
    Tokamak.T_profile(cur_rho)
  )

  cur_w /= n_para

  cur_w
end
