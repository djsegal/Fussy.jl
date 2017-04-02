"""
    f_CD()

Lorem ipsum dolor sit amet.
"""
function f_CD()
  cur_f_CD = K_CD()

  cur_f_CD *= ( n_bar / 1u"n20" )
  cur_f_CD *= ( R_0 / 1u"m" )^2
  cur_f_CD *= ( sigma_v_hat / 1u"m^3/s" )
  cur_f_CD /= ( I_M / 1u"MA" )

  cur_f_CD
end
