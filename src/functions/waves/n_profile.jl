"""
    n_profile(rho)

Lorem ipsum dolor sit amet.
"""
function n_profile(rho)
  cur_n_profile = ( 1 - rho ^ 2 ) ^ nu_n

  cur_n_profile *= calc_possible_values( solved_steady_density() / 1u"n20" )

  cur_n_profile *= ( 1 + nu_n )

  cur_n_profile
end
