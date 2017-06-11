@doc """
    ItPF(cur_R_0=R_0, cur_n_bar=n_bar, cur_I_M=I_M)

Lorem ipsum dolor sit amet.
"""
@memoize function ItPF(cur_R_0=R_0, cur_n_bar=n_bar, cur_I_M=I_M)

  Bv = betap() |> NoUnits

  Bv += log( 8 * cur_R_0 / a(cur_R_0) )

  Bv += ( magnet_li() - 3 ) / 2

  Bv *= standard_mu_0

  Bv *= ( cur_I_M / 1u"A" )

  Bv /= 4

  Bv /= pi

  Bv /= ( cur_R_0 / 1u"m" )

  # Total Field at center from Div and PF

  Bvtotal = BzDivs() + BzPFs()

  # With safety factor find ratio for new size reactor

  cur_scale = Bvtotal / Bv

  cur_ItPF = []

  append!(cur_ItPF, magnet_Id_array())
  append!(cur_ItPF, magnet_Ip_array())

  # Scale the currents with safety factor 1.25

  cur_ItPF *= 1.25

  cur_scale = Bvtotal / Bv

  cur_ItPF /= max(cur_scale, 1/cur_scale)

  push!(cur_ItPF, ( cur_I_M / 1u"A" ))

  cur_ItPF = map( x -> ( x |> NoUnits ) , cur_ItPF )

  has_actual_values = eltype(cur_R_0 / 1u"m") != SymPy.Sym
  has_actual_values &= eltype(cur_n_bar / 1u"n20") != SymPy.Sym
  has_actual_values &= eltype(cur_I_M / 1u"MA") != SymPy.Sym

  if has_actual_values
    cur_ItPF = map( x ->
      magnet_subs(x, cur_R_0, cur_n_bar, cur_I_M),
      cur_ItPF
    )
  end

  cur_ItPF

end
