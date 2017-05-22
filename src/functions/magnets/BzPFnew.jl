"""
    BzPFnew()

Lorem ipsum dolor sit amet.
"""
function BzPFnew()

  cur_BzPFnew = zeros(1, 4)

  cur_magnet_rhop = magnet_rhop()
  cur_magnet_etap = magnet_etap()
  cur_magnet_kp = magnet_kp()

  cur_B0pnew = B0pnew()

  for i = 1:4
    cur_BzPFnew[i] = Bzfunc(cur_magnet_rhop[i],cur_magnet_etap[i],cur_B0pnew[i],cur_magnet_kp[i])
  end

  cur_BzPFnew

end
