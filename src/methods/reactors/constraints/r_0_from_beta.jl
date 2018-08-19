function R_0_from_beta(cur_reactor::AbstractReactor)
  cur_R = K_TB(cur_reactor)

  cur_R *= cur_reactor.T_bar

  cur_R /= safe_symbol(cur_reactor, :B_0)

  cur_R
end
