"""
    hts_thickness()

Lorem ipsum dolor sit amet.
"""
function hts_thickness()

  cur_hts_thickness = solenoid_current()

  cur_hts_thickness /= magnet_Jsol

  cur_hts_thickness /= solenoid_length()

  cur_hts_thickness

end
