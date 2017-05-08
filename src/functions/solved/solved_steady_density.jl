"""
    solved_steady_density()

Lorem ipsum dolor sit amet.
"""
function solved_steady_density()
  cur_solved_density = K_n()

  cur_solved_density /= K_CD_denom

  cur_solved_density *= ( T_k / 1u"keV" )

  cur_solved_density /= ( R_0 / 1u"m" ) ^ 2

  cur_solved_density *= 1u"n20"

  cur_solved_density
end
