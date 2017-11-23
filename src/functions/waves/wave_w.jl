"""
    wave_w(cur_rho)

Lorem ipsum dolor sit amet.
"""
function wave_w(cur_rho)
  cur_w = Unitful.c0

  cur_w /= Plasmas.v_Te()

  cur_w = subs(
    cur_w,
    Plasmas.symbol_dict["T_e"],
    Fusion.T_profile(cur_rho)
  )

  cur_w /= n_para

  cur_w
end
