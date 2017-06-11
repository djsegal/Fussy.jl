@doc """
    BzDivs()

Divertor Field Contribution.
"""
@memoize function BzDivs()

  B0d = magnet_Id_array()

  B0d ./= magnet_rd_array()

  B0d *= standard_mu_0

  B0d /= 2

  BzDiv = Array{Any}(1, 6)

  cur_magnet_rhod = magnet_rhod()
  cur_magnet_etad = magnet_etad()
  cur_magnet_kd = magnet_kd()

  for i = 1:6
    BzDiv[i] = Bzfunc(cur_magnet_rhod[i],cur_magnet_etad[i],B0d[i],cur_magnet_kd[i])
  end

  cur_BzDivs = sum(BzDiv) # Total Divertor Field at Center of Plasma

  cur_BzDivs

end
