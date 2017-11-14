"""
    wave_omega_hat_2(cur_rho; cur_wave_chi=nothing)

Lorem ipsum dolor sit amet.
"""
function wave_omega_hat_2(cur_rho; cur_wave_chi=nothing)

  if cur_wave_chi == nothing
    cur_wave_chi = wave_chi(cur_rho)
  end

  cur_block = cur_wave_chi

  cur_block /= ( 1 + cur_wave_chi )

  cur_left_part = cur_block

  cur_left_part ^= 2

  cur_right_part = 4.0

  cur_right_part *= wave_gamma ^ 2

  cur_right_part *= cur_block

  cur_right_part *= cur_wave_chi ^ 2

  cur_omega_2 = cur_left_part

  cur_omega_2 += cur_right_part

  cur_omega_2 ^= ( 1 / 2 )

  cur_omega_2 += cur_block

  cur_omega_2 /= 2

  cur_omega_2

end
