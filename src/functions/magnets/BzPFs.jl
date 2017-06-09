"""
    BzPFs()

Lorem ipsum dolor sit amet.
"""
function BzPFs()

  B0p = magnet_Ip_array()

  B0p ./= magnet_rp_array()

  B0p *= standard_mu_0

  B0p /= 2

  BzPF = Array{Any}(1, 4)

  cur_magnet_rhop = magnet_rhop()
  cur_magnet_etap = magnet_etap()
  cur_magnet_kp = magnet_kp()

  for i = 1:4
    BzPF[i] = Bzfunc(cur_magnet_rhop[i],cur_magnet_etap[i],B0p[i],cur_magnet_kp[i])
  end

  cur_BzPFs = sum(BzPF) # Total PF Field at Center of Plasma

  cur_BzPFs

end
