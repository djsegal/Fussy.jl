"""
    K_3()

Lorem ipsum dolor sit amet.
"""
function K_3()
  cur_K_3 = K_W()

  cur_K_3 *= K_n() ^ 2

  cur_K_3 /= P_W / ( 1u"MW" / 1u"m^2" )

  cur_K_3
end
