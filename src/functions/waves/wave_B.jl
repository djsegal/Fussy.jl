"""
    wave_B(cur_rho)

Lorem ipsum dolor sit amet.
"""
function wave_B(cur_rho, cur_theta=copy(wave_theta))
  cur_theta *= ( pi / 180 )

  cur_denom = epsilon

  cur_denom *= cur_rho

  cur_denom *= cos( cur_theta )

  cur_denom += 1.0

  cur_B = B_0

  cur_B /= cur_denom

  cur_B
end
