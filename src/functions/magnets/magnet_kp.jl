"""
    magnet_kp()

Lorem ipsum dolor sit amet.
"""
function magnet_kp()

  cur_magnet_kp = 4 * magnet_rhop()

  cur_magnet_kp ./= ( 1 + magnet_rhop() ) .^ 2 + magnet_etap() .^ 2

  cur_magnet_kp

end
