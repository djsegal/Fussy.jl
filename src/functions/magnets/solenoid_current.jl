@doc """
    solenoid_current()

Lorem ipsum dolor sit amet.
"""
@memoize function solenoid_current()

  cur_solenoid_current = magnet_B_1

  cur_solenoid_current *= solenoid_length()

  cur_solenoid_current /= standard_mu_0

  cur_solenoid_current

end
