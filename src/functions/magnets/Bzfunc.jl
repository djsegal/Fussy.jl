@doc """
    Bzfunc(rho, eta, curB, k)

Bz Field Contribution.
"""
@memoize function Bzfunc(rho, eta, curB, k)

  cur_Bzfunc = ( 1 - rho^2 - eta^2 )

  cur_Bzfunc /= ( (1-rho)^2 + eta^2 )

  cur_Bzfunc *= elliptice(k)

  cur_Bzfunc += elliptick(k)

  cur_Bzfunc *= curB

  cur_Bzfunc /= pi

  cur_Bzfunc /= ( (1+rho)^2 + eta^2 ) ^ 0.5

  cur_Bzfunc

end
