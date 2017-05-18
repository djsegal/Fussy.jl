"""
    solenoid_length()

Lorem ipsum dolor sit amet.
"""
function solenoid_length()

  cur_solenoid_length = kappa * a()

  cur_solenoid_length += magnet_b()

  cur_solenoid_length /= 1u"m"

  cur_solenoid_length *= 2

  cur_solenoid_length *= 1.15

  cur_solenoid_length
end
