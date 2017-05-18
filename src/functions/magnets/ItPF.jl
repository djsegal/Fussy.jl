"""
    ItPF()

Lorem ipsum dolor sit amet.
"""
function ItPF()
  Bv = standard_mu_0*( I_M / 1u"A" )/(4*pi*( R_0 / 1u"m" ))*(betap() + (magnet_li()-3)/2 + log(8*( R_0 / 1u"m" )/( a() / 1u"m" )))

  Bvtotal = BzDivs() + BzPFs()         # Total Field at center from Div and PF
  cur_scale = Bvtotal/Bv               # With safety factor find ratio for new size reactor

  cur_ItPF = []

  append!(cur_ItPF, magnet_Id_array())
  append!(cur_ItPF, magnet_Ip_array())

  if cur_scale < 1
   cur_ItPF = 1.25*cur_ItPF*cur_scale   # Scale the currents with safety factor 1.25
  else
    if cur_scale > 1
      cur_ItPF = 1.25*cur_ItPF/cur_scale
    end
  end

  push!(cur_ItPF, ( I_M / 1u"A" ) |> NoUnits)

  cur_ItPF = map(x -> x , cur_ItPF)

  cur_ItPF
end
