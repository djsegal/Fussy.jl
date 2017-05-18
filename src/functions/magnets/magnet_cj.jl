"""
    magnet_cj()

Lorem ipsum dolor sit amet.
"""
function magnet_cj()
  cj = zeros(1,10)

  for p = 1:10
    cj[p] = abs(Tokamak.ItPF()[p])/(Tokamak.magnet_PF_coil_length*Tokamak.magnet_Jmax)
  end

  cj
end
