"""
    omega_ce(rho)

Lorem ipsum dolor sit amet.
"""
function omega_ce(rho)
  cur_omega = ( Unitful.q / 1u"C" )

  cur_omega *= local_B(rho)

  cur_omega /= ( Unitful.me / 1u"kg" )

  cur_omega
end
