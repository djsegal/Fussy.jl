function I_P_from_beta_kink(cur_reactor::AbstractReactor)
  cur_I = K_TB(cur_reactor)

  cur_I /= K_KF(cur_reactor)

  cur_I *= cur_reactor.T_bar

  cur_I
end
