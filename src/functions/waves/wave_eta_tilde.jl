"""
    wave_eta_tilde(cur_rho)

Lorem ipsum dolor sit amet.
"""
function wave_eta_tilde(cur_T_k, cur_rho, cur_n_para)
  cur_w = subs(
    wave_w(cur_rho),
    symbol_dict["T_k"] => cur_T_k,
    symbol_dict["n_para"] => cur_n_para,
  )

  cur_eta = wave_M

  cur_eta *= wave_R(cur_rho, cur_w=cur_w)

  cur_eta *= wave_C(cur_rho, cur_w=cur_w)

  cur_eta *= wave_eta_0(cur_rho, cur_w=cur_w)

  cur_eta
end
