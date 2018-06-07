function R_0_from_wall(cur_reactor::AbstractReactor)
  cur_R = K_WL(cur_reactor)

  cur_R *= cur_reactor.I_P ^ (2/3)

  cur_R *= cur_reactor.sigma_v ^ (1/3)

  cur_R
end
