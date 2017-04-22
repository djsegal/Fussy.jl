"""
    K_W()

Lorem ipsum dolor sit amet.
"""
function K_W()
  cur_K_W = 1.398

  cur_K_W *= N_G ^ 4
  cur_K_W *= kappa ^ (7/2)
  cur_K_W *= C_B() ^ 2

  cur_K_W /= ( P_W / ( 1u"MW" / 1u"m^2" ) )
  cur_K_W /= epsilon ^ 2
  cur_K_W /= l_over_2_pi_a()

  cur_K_W
end
