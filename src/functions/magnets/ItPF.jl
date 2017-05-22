"""
    ItPF()

Lorem ipsum dolor sit amet.
"""
function ItPF()

  Bv = betap()

  Bv += log( 8 * R_0 / a() )

  Bv += ( magnet_li() - 3 ) / 2

  Bv *= standard_mu_0

  Bv *= ( I_M / 1u"A" )

  Bv /= 4

  Bv /= pi

  Bv /= ( R_0 / 1u"m" )

  # Total Field at center from Div and PF

  Bvtotal = BzDivs() + BzPFs()

  # With safety factor find ratio for new size reactor

  cur_scale = Bvtotal / Bv

  cur_ItPF = []

  append!(cur_ItPF, magnet_Id_array())
  append!(cur_ItPF, magnet_Ip_array())

  # Scale the currents with safety factor 1.25

  if cur_scale > 1
    cur_ItPF = 1.25*cur_ItPF/cur_scale
  else
    cur_ItPF = 1.25*cur_ItPF*cur_scale
  end

  push!(cur_ItPF, ( I_M / 1u"A" ) |> NoUnits)

  cur_ItPF

end
