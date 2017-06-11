@doc """
    magnet_rpp(cur_R_0=R_0, cur_n_bar=n_bar, cur_I_M=I_M)

Lorem ipsum dolor sit amet.
"""
@memoize function magnet_rpp(cur_R_0=R_0, cur_n_bar=n_bar, cur_I_M=I_M)

  rm = 3.3

  cur_magnet_rpp = []

  append!(cur_magnet_rpp, magnet_rd_array())

  append!(cur_magnet_rpp, magnet_rp_array())

  push!(cur_magnet_rpp, rm)

  has_actual_values = eltype(cur_R_0 / 1u"m") != SymPy.Sym
  has_actual_values &= eltype(cur_n_bar / 1u"n20") != SymPy.Sym
  has_actual_values &= eltype(cur_I_M / 1u"MA") != SymPy.Sym

  if has_actual_values
    cur_magnet_rpp = map( x ->
      magnet_subs(x, cur_R_0, cur_n_bar, cur_I_M),
      cur_magnet_rpp
    )
  end

  cur_magnet_rpp

end
