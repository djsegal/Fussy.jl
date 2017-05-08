"""
    solved_steady_current()

Lorem ipsum dolor sit amet.
"""
function solved_steady_current()
  cur_solved_current = K_I()

  cur_solved_current /= K_CD_denom

  cur_solved_current *= ( T_k / 1u"keV" )

  cur_solved_current *= 1u"MA"

  cur_solved_current
end
