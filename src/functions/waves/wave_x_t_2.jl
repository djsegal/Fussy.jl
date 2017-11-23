"""
    wave_x_t_2(cur_rho; cur_w=nothing)

Lorem ipsum dolor sit amet.
"""
function wave_x_t_2(cur_rho; cur_w=nothing)
  if cur_w == nothing
    cur_w = wave_w(cur_rho)
  end

  cur_B = wave_B(cur_rho)

  cur_x_t_2 = cur_w ^ 2

  cur_x_t_2 *= cur_B

  cur_denom = wave_B_M(cur_rho)

  cur_denom -= cur_B

  cur_x_t_2 /= cur_denom

  cur_x_t_2 *= 2

  cur_x_t_2
end
