"""
    Area_St()

Determine Steel Structure Dimensions.
"""
function Area_St()
  Force_St = magnet_Imax()*Cable_L()*B_coil_max() # estimate of force on cable due to magnetic field
  St_Yield = 800e6 # estimated yield strength of steel
  cur_Area_St = Force_St/((2/3)*St_Yield) # area of steel component of cable

  cur_Area_St
end
