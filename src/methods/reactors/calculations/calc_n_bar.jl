function calc_n_bar(cur_reactor::AbstractReactor)
  cur_n = K_n(cur_reactor)

  cur_n *= cur_reactor.I_P

  cur_n /= cur_reactor.R_0 ^ 2

  cur_n
end
