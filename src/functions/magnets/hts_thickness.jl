"""
    hts_thickness()

Lorem ipsum dolor sit amet.
"""
function hts_thickness()
  solenoid_current()/(Tokamak.magnet_Jsol*Tokamak.solenoid_length())
end
