"""
    W_mag()

Lorem ipsum dolor sit amet.
"""
function W_mag()
  cur_W_mag = pi

  cur_W_mag *= epsilon ^ 2

  cur_W_mag *= ( B_0 / 1u"T" ) ^ 2

  cur_W_mag *= ( R_0 / 1u"m" ) ^ 3

  cur_W_mag /= 400

  cur_W_mag
end
