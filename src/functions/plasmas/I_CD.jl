"""
    I_CD()

Lorem ipsum dolor sit amet.
"""
function I_CD()
  cur_I_CD = eta_CD
  cur_I_CD /= Q

  cur_I_CD *= P_F()
  cur_I_CD /= n_bar
  cur_I_CD /= ( R_0 / 1u"m" )

  cur_I_CD
end
