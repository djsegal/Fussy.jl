@doc """
    magnet_etap()

Lorem ipsum dolor sit amet.
"""
@memoize function magnet_etap()

  cur_magnet_etap = magnet_zp_array()

  cur_magnet_etap ./= magnet_rp_array()

  cur_magnet_etap

end
