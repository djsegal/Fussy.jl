"""
    betap()

Lorem ipsum dolor sit amet.
"""
function betap()
  Bta = standard_mu_0*( I_M / 1u"A" )/(2*pi*( a() / 1u"m" ))
  # Pressure Calculation
  nt=1.3
  nn = 0.5
  sigma=0.1
  xaa=0.3*(1-delta^2)
  c0 = -delta/2
  c1 = 1/8*(9-2*delta-xaa)
  c2 = delta/2
  c3 = 1/8*(-1+2*delta+xaa)
  press = 2*( n_bar / 1u"m^-3" )*( ( T_k / 1u"eV" ) * 11600 )*( Unitful.k / 1u"J/K" )*(1+nn)*(1+nt)/(1+nn+nt)*(c1 + ( a() / 1u"m" )/( R_0 / 1u"m" )*(6*c0*c1+3*c2*c3+c1*
     (3+nn+nt)*(c2+sigma*(nn+nt)))/((2+nn+nt)*(3+nn+nt))) |> NoUnits
  cur_betap = 2*standard_mu_0*press/(Bta^2)

  cur_betap
end
