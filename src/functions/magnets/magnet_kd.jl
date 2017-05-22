"""
    magnet_kd()

Lorem ipsum dolor sit amet.
"""
function magnet_kd()

  cur_magnet_kd = 4 * magnet_rhod()

  cur_magnet_kd ./= ( 1 + magnet_rhod() ) .^ 2 + magnet_etad() .^ 2

  cur_magnet_kd

end
