@doc """
    Coil_Inductance(cur_R_0=R_0, cur_n_bar=n_bar, cur_I_M=I_M)

TF coil inductance.
"""
@memoize function Coil_Inductance(cur_R_0=R_0, cur_n_bar=n_bar, cur_I_M=I_M)

  cur_dR = magnet_inner_radius() + magnet_material_thickness(cur_R_0, cur_n_bar, cur_I_M) / 2

  R1 = ( R_0 / 1u"m" ) - cur_dR # Radius from center of CS to TF straight leg
  R2 = ( R_0 / 1u"m" ) + cur_dR # Radius from center of CS to TF outter D

  Ro = ( R1 * R2 ) ^ 0.5

  K = 0.5 * log( R2 / R1 )

  cur_bessel_func = besseli(0,K) + 2 * besseli(1,K) + besseli(2,K)

  cur_Coil_Inductance = standard_mu_0

  cur_Coil_Inductance *= magnet_turns() ^ 2

  cur_Coil_Inductance *= K ^ 2

  cur_Coil_Inductance *= Ro

  cur_Coil_Inductance *= cur_bessel_func

  cur_Coil_Inductance /= 2

  cur_Coil_Inductance

end
