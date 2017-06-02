"""
    magnet_Q_80()

Heating due to thermal shielding @ 80K [kW].
"""
function magnet_Q_80()

  cur_Q_80 = 800.0

  cur_Q_80 *= 1 + kappa ^ 2

  cur_Q_80 *= ( R_0 / 1u"m" )

  cur_Q_80 *= ( a() / 1u"m" )

  cur_Q_80 /= 48.2

  cur_Q_80

end
