"""
    Q_E(cur_Q=Q)

Lorem ipsum dolor sit amet.
"""
function Q_E(cur_Q=Q)

  cur_Q_E = E_Li

  cur_Q_E /= E_F()

  cur_Q_E += 1

  cur_Q_E *= cur_Q

  cur_Q_E += 1

  cur_Q_E *= eta_T

  cur_Q_E *= eta_RF

  cur_Q_E -= 1

  cur_Q_E

end
