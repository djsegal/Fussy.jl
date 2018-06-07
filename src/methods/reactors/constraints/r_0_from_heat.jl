function R_0_from_heat(cur_reactor::AbstractReactor)
  cur_R = K_DV(cur_reactor)

  cur_R *= cur_reactor.I_P

  cur_R *= cur_reactor.sigma_v ^ (1/3.2)

  cur_R
end
