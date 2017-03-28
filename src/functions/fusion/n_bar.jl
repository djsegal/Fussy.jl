"""
    n_bar(R_0, I_M)

Lorem ipsum dolor sit amet.
"""
function n_bar(R_0, I_M)

  0.3183 * N_G * ( (I_M/1u"MA") / ( epsilon * (R_0/1u"m") )^2 )

end
