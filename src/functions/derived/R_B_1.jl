"""
    R_B_1()

Lorem ipsum dolor sit amet.
"""
function R_B_1()
  cur_R_B = ( R_0 / 1u"m" ) ^ power_balance_r_exp()

  cur_R_B /= ( B_0 / 1u"T" ) ^ alphas["B_0"]

  cur_R_B
end
