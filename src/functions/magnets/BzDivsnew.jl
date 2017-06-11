@doc """
    BzDivsnew()

Calculate New BV due to Divertor.
"""
@memoize function BzDivsnew()

  B0dnew = ItPF()[1:6]'

  B0dnew ./= magnet_rd_array()

  B0dnew *= standard_mu_0

  B0dnew /= 2

  BzDivnew = zeros(1, 6)

  cur_magnet_rhod = magnet_rhod()
  cur_magnet_etad = magnet_etad()
  cur_magnet_kd = magnet_kd()

  for i = 1:6
    BzDivnew[i] = Bzfunc(cur_magnet_rhod[i],cur_magnet_etad[i],B0dnew[i],cur_magnet_kd[i])
  end

  cur_BzDivsnew = sum(BzDivnew)

  cur_BzDivsnew

end
