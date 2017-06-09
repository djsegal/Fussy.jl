"""
    magnet_centering_force(cur_R_0=R_0, cur_n_bar=n_bar, cur_I_M=I_M)

Net Centering Force.
"""
function magnet_centering_force(cur_R_0=R_0, cur_n_bar=n_bar, cur_I_M=I_M)

  FC = magnet_inward_centering()

  FC += magnet_outward_centering(cur_R_0, cur_n_bar, cur_I_M)

  FC *= 2

  FC = abs(FC)

  FC

end
