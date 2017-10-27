"""
    P_E()

Lorem ipsum dolor sit amet.
"""
function P_E()

  cur_P_E = E_Li

  cur_P_E /= E_F()

  cur_P_E += 1

  cur_P_E *= P_F()

  cur_P_E /= P_H()

  cur_P_E += 1

  cur_P_E *= P_H()

  cur_P_E *= eta_T

  cur_P_E

end
