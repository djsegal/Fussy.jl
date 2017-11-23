"""
    wave_R(cur_rho; cur_w=nothing)

Lorem ipsum dolor sit amet.
"""
function wave_R(cur_rho; cur_w=nothing)
  if cur_w == nothing
    cur_w = wave_w(cur_rho)
  end

  cur_left_part = epsilon

  cur_left_part *= cur_rho

  cur_left_part ^= wave_n

  cur_right_part = wave_x_r ^ 2

  cur_right_part += cur_w ^ 2

  cur_right_part ^= ( 1 / 2 )

  cur_denom = cur_left_part

  cur_denom *= wave_x_r

  cur_denom += cur_w

  cur_R = -1.0

  cur_R *= cur_left_part

  cur_R *= cur_right_part

  cur_R /= cur_denom

  cur_R += 1.0

  cur_R
end
