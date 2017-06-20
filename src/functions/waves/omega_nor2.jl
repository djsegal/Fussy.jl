"""
    omega_nor2(rho_J, cur_wave_chi=nothing)

Lorem ipsum dolor sit amet.
"""
function omega_nor2(rho_J, cur_wave_chi=nothing)

  if cur_wave_chi == nothing
    cur_wave_chi = wave_chi(rho_J)
  end

  cur_omega_nor2 = 0.5*cur_wave_chi/(1+cur_wave_chi)

  cur_omega_nor2 += 0.5*( cur_wave_chi^2/(1+cur_wave_chi)^2 + 4*wave_gamma0^2*cur_wave_chi^3/(1+cur_wave_chi) )^0.5

  cur_omega_nor2

end
