"""
    Bzfunc(rho, eta, curB, k)

Bz Field Contribution.
"""
function Bzfunc(rho, eta, curB, k)
  cur_Bzfunc = (curB/pi)

  cur_Bzfunc *= (1/((1+rho)^2+eta^2)^0.5)

  cur_Bzfunc *= (
    Elliptic.K(k) +
    (1-rho^2-eta^2)/((1-rho)^2+eta^2)*Elliptic.E(k)
  )

  cur_Bzfunc
end
