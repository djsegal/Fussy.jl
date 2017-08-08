"""
    q_star()

Lorem ipsum dolor sit amet.
"""
function q_star()
  cur_q_star = 1 + kappa ^ 2

  cur_q_star /= 2

  cur_q_star *= epsilon ^ 2

  cur_q_star *= 5

  cur_q_star *= ( B_0 / 1u"T" )

  cur_q_star *= ( R_0 / 1u"m" )

  cur_q_star /= ( I_M / 1u"MA" )

  cur_q_star
end
