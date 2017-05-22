"""
    Tape_N()

Number of tapes per 12x12 mm HTS stack.
"""
function Tape_N()

  cur_Tape_N = Tape_w

  cur_Tape_N /= Tape_t

  cur_Tape_N = ceil(cur_Tape_N)

  cur_Tape_N

end
