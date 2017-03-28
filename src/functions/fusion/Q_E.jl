"""
    Q_E()

Lorem ipsum dolor sit amet.
"""
function Q_E()

  cur_Q_E = E_F() + E_Li
  cur_Q_E /= E_F()
  cur_Q_E *= Q

  cur_Q_E += 1
  cur_Q_E *= eta_T * eta_RF
  cur_Q_E -= 1

  cur_Q_E

end
