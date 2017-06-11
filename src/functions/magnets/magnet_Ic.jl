@doc """
    magnet_Ic()

Current per coil.
"""
@memoize function magnet_Ic()

  # Total Current for given ( B_0 / 1u"T" )

  ITF = 2 * pi

  ITF *= ( B_0 / 1u"T" )

  ITF *= ( R_0 / 1u"m" )

  ITF /= standard_mu_0

  Ic = ITF

  Ic /= magnet_num_coils

  Ic

end
