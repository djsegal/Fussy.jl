"""
    magnet_centering_force()

Net Centering Force.
"""
function magnet_centering_force()
  FC = magnet_inward_centering()
  FC += magnet_outward_centering()
  FC *= 2

  FC = abs(FC)

  FC
end
