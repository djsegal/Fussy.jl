"""
    BzDivsnew()

Calculate New BV due to Divertor.
"""
function BzDivsnew()

  BzDivnew = zeros(1,6)
  B0dnew = (standard_mu_0/2).*ItPF()[1:6]'./magnet_rd_array()
  for i = 1:6
    BzDivnew[i] = Bzfunc(magnet_rhod()[i],magnet_etad()[i],B0dnew[i],magnet_kd()[i])
  end
  cur_BzDivsnew = sum(BzDivnew)

  cur_BzDivsnew

end
