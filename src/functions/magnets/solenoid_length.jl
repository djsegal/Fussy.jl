"""
    solenoid_length()

Lorem ipsum dolor sit amet.
"""
function solenoid_length()

  cur_solenoid_length = a_kappa()

  cur_solenoid_length += blanket_thickness()

  cur_solenoid_length /= 1u"m"

  cur_solenoid_length *= 2

  cur_solenoid_length *= 1.15

  cur_solenoid_length

end
