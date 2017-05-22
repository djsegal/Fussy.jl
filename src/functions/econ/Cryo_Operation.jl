"""
    Cryo_Operation()

Cost of power @ 0.1 \$/kWhr to power the cryoplant annually.
"""
function Cryo_Operation()

  cur_magnet_Q_total = magnet_Q_total()

  cur_Cryo_Operation = cur_magnet_Q_total

  cur_Cryo_Operation /= ( 15 / ( 300 - 15 ) )

  cur_Cryo_Operation /= ( 0.141 * cur_magnet_Q_total ^ 0.26 )

  cur_Cryo_Operation *= ( 24 * 365 )

  cur_Cryo_Operation *= 0.1

  cur_Cryo_Operation *= 1.08

  cur_Cryo_Operation

end
