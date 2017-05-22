"""
    magnet_Imax()

Lorem ipsum dolor sit amet.
"""
function magnet_Imax()

  It = 4670*B_coil_max()^-0.796 # Critical current of 12mm tape @ 20K [A/mm2]

  Jc = It/Tape_w/Tape_t/1000000 # Critical current density @ 20 K [A/mm2]

  Jop = Jc*FOS # Operating critical current density [A/mm2]

  Imax = Jop*Tape_w^2*1000 # Max current per 12x12mm HTS stack [kA]

  Imax

end
