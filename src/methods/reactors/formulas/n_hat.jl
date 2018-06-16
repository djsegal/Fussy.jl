function n_hat(cur_reactor::AbstractReactor)
  cur_nu_n = cur_reactor.nu_n

  cur_n = 0.5

  cur_n *= sqrt( cur_reactor.pi )

  cur_n *= gamma( cur_nu_n + 2.0 )

  cur_n /= gamma( cur_nu_n + 3/2 )

  cur_n *= cur_reactor.n_bar

  cur_n
end
