"""
    rho_m()

Lorem ipsum dolor sit amet.
"""
function rho_m()

  ( bootstrap_gamma < 1 ) && return 0.0

  cur_rho = bootstrap_gamma

  cur_rho /= ( bootstrap_gamma - 1.0 )

  cur_rho ^= ( 1 / 2 )

  cur_rho

end
