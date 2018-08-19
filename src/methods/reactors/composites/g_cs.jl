@symbol_func function G_CS(cur_reactor::AbstractReactor)
  cur_G = h_CS(cur_reactor)

  cur_G *= G_LO(cur_reactor)

  cur_G *= safe_symbol(cur_reactor, :R_0) ^ 3

  cur_G *= cur_reactor.T_bar

  cur_G ^= (1/2)

  cur_G
end
