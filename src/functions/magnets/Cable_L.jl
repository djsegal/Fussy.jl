"""
    Cable_L()

Length of one cable [m].
"""
function Cable_L()

  cur_Cable_L = WP_d()

  cur_Cable_L *= Coil_P()

  cur_Cable_L

end
