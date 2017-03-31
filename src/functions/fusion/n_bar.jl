"""
    n_bar(I_M)

Lorem ipsum dolor sit amet.
"""
function n_bar(I_M)
  cur_n_bar = 0.3183

  cur_n_bar *= N_G
  cur_n_bar *= I_M / 1u"MA"
  cur_n_bar /= epsilon ^ 2
  cur_n_bar /= ( R_0 / 1u"m" ) ^ 2

  cur_n_bar * 1u"n20"
end
