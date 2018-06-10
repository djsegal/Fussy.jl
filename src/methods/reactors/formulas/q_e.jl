@symbol_func function Q_E(cur_reactor::AbstractReactor)
  cur_Q = cur_reactor.Q

  cur_Q *= 1 + E_Li / E_F

  cur_Q += 1

  cur_Q *= cur_reactor.eta_T

  cur_Q *= cur_reactor.eta_RF

  cur_Q -= 1

  cur_Q
end
