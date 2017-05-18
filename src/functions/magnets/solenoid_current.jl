"""
    solenoid_current()

Lorem ipsum dolor sit amet.
"""
function solenoid_current()
  Tokamak.magnet_B_1*Tokamak.solenoid_length()/Tokamak.standard_mu_0
end
