"""
    BzPFs()

Lorem ipsum dolor sit amet.
"""
function BzPFs()

  B0p = (standard_mu_0/2)*magnet_Ip_array()./magnet_rp_array()

  BzPF = zeros(1,4)
  for i = 1:4
    BzPF[i] = Bzfunc(magnet_rhop()[i],magnet_etap()[i],B0p[i],magnet_kp()[i])
  end

  cur_BzPFs = sum(BzPF) # Total PF Field at Center of Plasma

  cur_BzPFs

end
