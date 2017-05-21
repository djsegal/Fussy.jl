"""
    d_shape_array()

Lorem ipsum dolor sit amet.
"""
function d_shape_array()

  cur_c_part = 1.0

  cur_c_part -= 2 * delta
  cur_c_part -= x_aa_of_pi()

  cur_c_part /= 8.0

  cur_shape_array = [
    0 - delta / 2.0
    1 + cur_c_part
    0 + delta / 2.0
    0 - cur_c_part
  ]

  cur_shape_array

end
