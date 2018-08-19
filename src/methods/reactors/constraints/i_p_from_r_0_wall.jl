function I_P_from_R_0_wall(cur_reactor::AbstractReactor, cur_value::Number)
  cur_I = cur_value

  cur_I /= K_WL(cur_reactor)

  cur_I ^= 3

  cur_I /= cur_reactor.sigma_v

  cur_I ^= (1/2)

  cur_I
end

