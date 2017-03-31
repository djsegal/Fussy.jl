"""
    steady_state()

Lorem ipsum dolor sit amet.
"""
function steady_state()
  cur_steady_state = f_CD()
  cur_steady_state += f_B()
  cur_steady_state -= 1

  cur_steady_state
end
