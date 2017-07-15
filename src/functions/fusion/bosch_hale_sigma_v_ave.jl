"""
    bosch_hale_sigma_v_ave(rho; cur_T_k=T_k)

Lorem ipsum dolor sit amet.
"""
function bosch_hale_sigma_v_ave(rho; cur_T_k=T_k)

  cur_local_T = local_T_k(rho, cur_T_k)

  cur_bg = pi

  cur_bg *= ( 1 / 137.03604 ) # alpha (fine struct const)

  cur_mrc2 = 1124656.0 # m_r * c^2

  cur_bg *= sqrt( 2.0 * cur_mrc2 )

  cur_cs = [
    +1.51361e-2,
    +7.51886e-2,
    +4.60643e-3,
    +1.35000e-2,
    -1.06750e-4,
    +1.36600e-5
  ]

  cur_theta = (
    cur_cs[1] + cur_local_T * (
      cur_cs[5] * cur_local_T + cur_cs[3]
    )
  )

  cur_theta /= (
    1 + cur_local_T * (
      cur_cs[2] + cur_local_T * (
        cur_cs[6] * cur_local_T + cur_cs[4]
      )
    )
  )

  cur_theta *= -cur_local_T

  cur_theta += 1

  cur_theta = cur_local_T / cur_theta

  cur_xi = cur_bg ^ 2

  cur_xi /= 4 * cur_theta

  cur_xi ^= ( 1 / 3.0 )

  cur_sigma_v_ave = 1.17302e-9

  cur_sigma_v_ave *= cur_theta

  cur_sigma_v_ave *= exp( -3 * cur_xi )

  cur_sigma_v_ave *= sqrt(
    cur_xi / ( cur_mrc2 * cur_local_T ^ 3 )
  )

  cur_sigma_v_ave *= 1e-6

  cur_sigma_v_ave *= 1u"m^3/s"

  cur_sigma_v_ave

end
