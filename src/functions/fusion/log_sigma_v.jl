"""
    log_sigma_v()

Lorem ipsum dolor sit amet.
"""
function log_sigma_v()

  cur_func = function (rho)
    cur_value = 1 - rho^2

    cur_value ^= 2 * nu_n

    cur_value *= sigma_v_ave(rho)

    cur_value *= rho

    cur_value /= 1u"m^3/s"

    cur_value
  end

  cur_sigma_v = ( 1 + nu_n )^2

  cur_sigma_v *= QuadGK.quadgk(cur_func, 0, 1)[1]

  cur_sigma_v *= 1u"m^3/s"

  cur_sigma_v

end
