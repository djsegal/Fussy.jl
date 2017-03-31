"""
    f_B(I_M)

Lorem ipsum dolor sit amet.
"""
function f_B(I_M)
  cur_f_B = K_B()

  cur_f_B *= ( T / 1u"keV" )
  cur_f_B *= ( n_bar(I_M) / 1u"n20" )
  cur_f_B *= ( R_0 / 1u"m" ) ^ 2
  cur_f_B /= ( I_M / 1u"MA" ) ^ 2

  cur_f_B
end
