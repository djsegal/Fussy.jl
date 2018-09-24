function pcap_equation(cur_reactor::AbstractReactor)
  cur_G_T = K_PC(cur_reactor)

  cur_G_T *= cur_reactor.sigma_v

  cur_equation = Equation(1, 0, -2, cur_G_T)

  cur_equation
end
