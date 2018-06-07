function R_0_from_kink(cur_reactor::AbstractReactor)
  cur_R = K_KF(cur_reactor)

  cur_R *= cur_reactor.I_P

  cur_R /= cur_reactor.B_0

  cur_R
end
