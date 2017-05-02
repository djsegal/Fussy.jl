"""
    solved_B_0_from_beta()

Lorem ipsum dolor sit amet.
"""
function solved_B_0_from_beta()
  solved_R_0 = solved_R_0_from_beta()

  cur_B_0 = K_beta()

  cur_B_0 *= ( T_k / 1u"keV" )
  cur_B_0 /= ( solved_R_0 / 1u"m" )

  cur_B_0 *= 1u"T"

  cur_B_0
end
