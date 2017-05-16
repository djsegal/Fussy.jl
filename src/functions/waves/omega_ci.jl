"""
    omega_ci(rho)

Lorem ipsum dolor sit amet.
"""
function omega_ci(rho)
  cur_omega = ( Unitful.q / 1u"C" )

  cur_omega *= local_B(rho)

  # D-T plasma, in kg
  cur_mi = ( 3.02 + 2.01 ) / 2.0
  cur_mi *=  1.66e-27

  cur_omega /= cur_mi

  cur_omega
end
