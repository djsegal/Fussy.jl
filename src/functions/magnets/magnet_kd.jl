@doc """
    magnet_kd()

Lorem ipsum dolor sit amet.
"""
@memoize function magnet_kd()

  cur_magnet_rhod = magnet_rhod()

  cur_magnet_kd = 4 * cur_magnet_rhod

  cur_magnet_kd ./= ( 1 + cur_magnet_rhod ) .^ 2 + magnet_etad() .^ 2

  cur_magnet_kd

end
