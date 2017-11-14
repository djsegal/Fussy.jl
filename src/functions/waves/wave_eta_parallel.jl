"""
    wave_eta_parallel(cur_rho; cur_wave_chi=nothing, cur_omega_hat_2=nothing)

Lorem ipsum dolor sit amet.
"""
function wave_eta_parallel(cur_rho; cur_wave_chi=nothing, cur_omega_hat_2=nothing)

  if cur_wave_chi == nothing
    cur_wave_chi = wave_chi(cur_rho)
  end

  if cur_omega_hat_2 == nothing
    cur_omega_hat_2 = wave_omega_hat_2(cur_rho, cur_wave_chi)
  end

  cur_eta_para = 1.0

  cur_eta_para -= cur_omega_hat_2

  cur_eta_para /= cur_omega_hat_2

  cur_eta_para *= cur_wave_chi

  cur_eta_para *= -1.0

  cur_eta_para += 1.0

  cur_eta_para ^= ( 1 / 2 )

  cur_eta_para += cur_wave_chi ^ ( 1 / 2 )

  cur_eta_para ^= 2

  cur_eta_para

end
