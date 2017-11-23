"""
    wave_C(cur_rho; cur_w=nothing)

Lorem ipsum dolor sit amet.
"""
function wave_C(cur_rho; cur_w=nothing)
  if cur_w == nothing
    cur_w = wave_w(cur_rho)
  end

  cur_exponent = wave_x_t_2(cur_rho, cur_w=cur_w)

  cur_exponent *= wave_c

  cur_exponent ^= wave_m

  cur_C = 1.0 - exp( -1.0 * cur_exponent )

  cur_C
end
