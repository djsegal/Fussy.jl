"""
    BzPFnew()

Lorem ipsum dolor sit amet.
"""
function BzPFnew()
  cur_BzPFnew = zeros(1,4)

  for i = 1:4
    cur_BzPFnew[i] = Bzfunc(magnet_rhop()[i],magnet_etap()[i],B0pnew()[i],magnet_kp()[i])
  end

  cur_BzPFnew
end
