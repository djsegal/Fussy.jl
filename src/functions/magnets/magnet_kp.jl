@doc """
    magnet_kp()

Lorem ipsum dolor sit amet.
"""
@memoize function magnet_kp()

  cur_magnet_rhop = magnet_rhop()

  cur_magnet_kp = 4 * cur_magnet_rhop

  cur_magnet_kp ./= ( 1 + cur_magnet_rhop ) .^ 2 + magnet_etap() .^ 2

  cur_magnet_kp

end
