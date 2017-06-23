@doc """
    magnet_zpp(cur_R_0=R_0, cur_n_bar=n_bar, cur_I_M=I_M)

Lorem ipsum dolor sit amet.
"""
@memoize function magnet_zpp(cur_R_0=R_0, cur_n_bar=n_bar, cur_I_M=I_M)

  zm = 0.0

  cur_magnet_zpp = []

  append!(cur_magnet_zpp, magnet_zd_array())

  append!(cur_magnet_zpp, magnet_zp_array())

  push!(cur_magnet_zpp, zm)

  has_actual_values = eltype(cur_R_0 / 1u"m") != SymPy.Sym
  has_actual_values &= eltype(cur_n_bar / 1u"n20") != SymPy.Sym
  has_actual_values &= eltype(cur_I_M / 1u"MA") != SymPy.Sym

  if has_actual_values
    cur_magnet_zpp = map( x ->
      magnet_subs(x, cur_R_0, cur_n_bar, cur_I_M),
      cur_magnet_zpp
    )
  end

  cur_magnet_zpp

end
