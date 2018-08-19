@symbol_func function b(cur_reactor::AbstractReactor)
  cur_P = P_W(cur_reactor)

  cur_n = cur_reactor.n_bar

  if isa(cur_n, SymEngine.Basic)
    cur_P = subs(
      cur_P, symbols(:n_bar) => calc_n_bar(cur_reactor)
    )
  end

  cur_b = 1.23

  cur_b += 0.074 * log( cur_P )

  cur_b
end
