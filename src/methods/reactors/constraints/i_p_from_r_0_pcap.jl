function I_P_from_R_0_pcap(cur_reactor::AbstractReactor, cur_value::Number)
  cur_I = cur_value

  cur_I /= K_PC(cur_reactor)

  cur_I /= cur_reactor.sigma_v

  cur_I ^= (1/2)

  cur_I
end
