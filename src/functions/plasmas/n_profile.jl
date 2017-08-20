"""
    n_profile(rho)

Lorem ipsum dolor sit amet.
"""
function n_profile(rho)

  cur_n_profile = ( 1 - rho ^ 2 ) ^ nu_n

  cur_n_profile *= ( 1 + nu_n )

  cur_n_profile *= ( n_bar / 1u"n20" )

  cur_n_profile

end
