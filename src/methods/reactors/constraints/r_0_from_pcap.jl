function R_0_from_pcap(cur_reactor::AbstractReactor)
  cur_R = K_PC(cur_reactor)

  cur_R *= cur_reactor.I_P ^ 2

  cur_R *= cur_reactor.sigma_v

  cur_R
end
