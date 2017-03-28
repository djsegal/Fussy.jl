function sigma_v()
  cur_func = function (rho)
    ( 1 - rho^2 )^( 2 * nu_n ) * rho
  end

  cur_sigma_v = sigma_v_ave()
  cur_sigma_v *= ( 1 + nu_n )^2
  cur_sigma_v *= QuadGK.quadgk(cur_func, 0, 1)[1]

  cur_sigma_v
end
