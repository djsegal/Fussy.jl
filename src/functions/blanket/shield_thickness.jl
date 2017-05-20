"""
    shield_thickness()

Lorem ipsum dolor sit amet.
"""
function shield_thickness()

  cur_a = 7.51e-08
  cur_b = -0.1539

  cur_neutron_source_rate = neutron_source_rate(P_W)

  # max flux: neutrons / m^2 /s
  seconds_in_a_year = 3.154e7

  mag_max_flux = magnet_max_neutron_fluence
  mag_max_flux /= plant_life_in_years
  mag_max_flux /= seconds_in_a_year

  # n / SourceN-cm^2
  max_N_per_source_N = mag_max_flux
  max_N_per_source_N /= cur_neutron_source_rate
  max_N_per_source_N /= 1e4

  cur_shield_thickness = max_N_per_source_N
  cur_shield_thickness /= cur_a
  cur_shield_thickness = log(cur_shield_thickness)
  cur_shield_thickness /= cur_b

  cur_shield_thickness = max(0u"m", cur_shield_thickness)

end
