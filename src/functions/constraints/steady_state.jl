"""
    steady_state(R_0, I_M)

Lorem ipsum dolor sit amet.
"""
function steady_state(R_0, I_M)
  cur_steady_state = f_CD(R_0, I_M)
  cur_steady_state += f_B(R_0, I_M)
  cur_steady_state -= 1

  cur_steady_state
end
