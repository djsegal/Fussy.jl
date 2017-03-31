"""
    steady_state(I_M)

Lorem ipsum dolor sit amet.
"""
function steady_state(I_M)
  cur_steady_state = f_CD(I_M)
  cur_steady_state += f_B(I_M)
  cur_steady_state -= 1

  cur_steady_state
end
