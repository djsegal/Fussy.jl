@doc """
    magnet_Frs(Ii)

Radial Self Force.
"""
@memoize function magnet_Frs(Ii)
  standard_mu_0*(Ii^2)/2*(log(8*R_0/a()) - 1)
end
