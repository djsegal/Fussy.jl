function I_P_from_R_0_heat(cur_reactor::AbstractReactor, cur_value::Number)
  cur_I = cur_value

  cur_I /= K_DV(cur_reactor)

  cur_I /= cur_reactor.sigma_v ^ (1/3.2)

  cur_I
end
