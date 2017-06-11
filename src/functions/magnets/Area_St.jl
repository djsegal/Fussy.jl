@doc """
    Area_St(cur_R_0=R_0, cur_n_bar=n_bar, cur_I_M=I_M)

Determine Steel Structure Dimensions.
"""
@memoize function Area_St(cur_R_0=R_0, cur_n_bar=n_bar, cur_I_M=I_M)

  # estimate of force on cable due to magnetic field

  Force_St = magnet_Imax()

  Force_St *= Cable_L(cur_R_0, cur_n_bar, cur_I_M)

  Force_St *= B_coil_max()

  # estimated yield strength of steel

  St_Yield = 800e6

  # area of steel component of cable

  cur_Area_St = Force_St

  cur_Area_St /= (2/3) * St_Yield

  cur_Area_St

end
