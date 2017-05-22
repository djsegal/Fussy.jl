"""
    BzDivs()

Divertor Field Contribution.
"""
function BzDivs()

  B0d = (standard_mu_0/2)*magnet_Id_array()./magnet_rd_array()

  BzDiv = zeros(1,6)
  for i = 1:6
    BzDiv[i] = Bzfunc(magnet_rhod()[i],magnet_etad()[i],B0d[i],magnet_kd()[i])
  end

  cur_BzDivs = sum(BzDiv) # Total Divertor Field at Center of Plasma

  cur_BzDivs

end
