"""
    I_CD()

Lorem ipsum dolor sit amet.
"""
function I_CD()
  cur_I_CD = eta_CD

  cur_I_CD *= ( P_H() / 1u"MW" )

  cur_I_CD /= ( n_bar / 1u"n20" )
  cur_I_CD /= ( R_0 / 1u"m" )

  cur_I_CD *= 1u"MA"

  cur_I_CD
end
