"""
    f_B(R_0, I_M)

Lorem ipsum dolor sit amet.
"""
function f_B(R_0, I_M)
  cur_f_B = K_B()

  cur_f_B *= n_bar(R_0, I_M) * T
  cur_f_B *= ( R_0 / I_M ) ^ 2

  cur_f_B
end
