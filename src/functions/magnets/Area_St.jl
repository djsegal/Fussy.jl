"""
    Area_St()

Determine Steel Structure Dimensions.
"""
function Area_St()

  # estimate of force on cable due to magnetic field

  Force_St = magnet_Imax()

  Force_St *= Cable_L()

  Force_St *= B_coil_max()

  # estimated yield strength of steel

  St_Yield = 800e6

  # area of steel component of cable

  cur_Area_St = Force_St

  cur_Area_St /= (2/3) * St_Yield

  cur_Area_St

end
