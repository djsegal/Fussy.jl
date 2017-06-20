"""
    n_para(rho_J, cur_wave_chi=nothing)

Lorem ipsum dolor sit amet.
"""
function n_para(rho_J, cur_wave_chi=nothing)

  if cur_wave_chi == nothing
    cur_wave_chi = wave_chi(rho_J)
  end

  cur_omega_nor2 = omega_nor2(rho_J, cur_wave_chi)

  cur_n_para = sqrt( ( (1-(1-cur_omega_nor2)*cur_wave_chi/cur_omega_nor2 )^0.5 + cur_wave_chi^0.5 )^2 )

  cur_n_para

end
