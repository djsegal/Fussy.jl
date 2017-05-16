"""
    omega_pe2(rho)

Lorem ipsum dolor sit amet.
"""
function omega_pe2(rho)
  cur_omega = n_profile(rho) * 1e20

  cur_omega *= ( Unitful.q / 1u"C" ) ^ 2

  cur_omega /= ( Unitful.me / 1u"kg" )

  cur_e0 = 8.85e-12 # F/m

  cur_omega /= cur_e0

  cur_omega
end
