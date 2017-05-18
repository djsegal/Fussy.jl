"""
    magnet_equation_set!(x, F)

Lorem ipsum dolor sit amet.
"""
function magnet_equation_set!(x, F)
  ## Flux Equation
  F[1] = Tokamak.standard_mu_0*( Tokamak.R_0 / 1u"m" )*Tokamak.magnet_li()*( Tokamak.I_M / 1u"A" )/2 - pi*Tokamak.magnet_B_1*x[1]^2 - pi*Tokamak.magnet_B_1*( (x[2]^2)/6 + x[1]*x[2]/2 )

  ## Stress Equation
  F[2] = Tokamak.magnet_Sysol - pi*Tokamak.magnet_B_1*solenoid_current()/(2*Tokamak.solenoid_length()*x[2]*(x[2]-hts_thickness()))*(x[2]^2/6+x[2]*x[1]/2) -
      Tokamak.standard_mu_0*solenoid_current()^2/(4*Tokamak.solenoid_length()^2*x[2]^2)*(x[2]^4/6 + 2/3*x[1]^3*x[2] + x[1]^2*x[2]^2) *
      1/((x[1]+x[2])^2 - (0.5*(2*x[1]+x[2])+hts_thickness()/2)^2 + (0.5*(2*x[1]+x[2])-hts_thickness()/2)^2-x[1]^2)
end
