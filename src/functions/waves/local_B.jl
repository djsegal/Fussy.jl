"""
    local_B(rho, cur_theta=wave_theta)

Lorem ipsum dolor sit amet.
"""
function local_B(rho, cur_theta=wave_theta)
  cur_theta *= ( pi / 180 )

  cur_local_B = ( B_0 / 1u"T" )

  cur_denom = epsilon

  cur_denom *= rho
  cur_denom *= cos(cur_theta)
  cur_denom += 1

  cur_local_B /= cur_denom

  cur_local_B
end
