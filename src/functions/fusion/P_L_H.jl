"""
    P_L_H()

Lorem ipsum dolor sit amet.
"""
function P_L_H()
  cur_P_L_H = 0.0976

  cur_P_L_H *= ( n_bar / 1u"n20" ) ^ 0.72

  cur_P_L_H *= ( B_0 / 1u"T" ) ^ 0.80

  cur_P_L_H *= ( surface_area() / 1u"m^2" ) ^ 0.94

  cur_P_L_H /= A

  cur_P_L_H *= 1u"MW"

  cur_P_L_H
end
