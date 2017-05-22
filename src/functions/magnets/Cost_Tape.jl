"""
    Cost_Tape()

Lorem ipsum dolor sit amet.
"""
function Cost_Tape()

  cur_Cost_Tape = Price_HTS

  cur_Cost_Tape *= Tape_L()

  # number of cables per coil

  Cable_N = WP_w()

  cur_Cost_Tape *= Cable_N

  cur_Cost_Tape

end
