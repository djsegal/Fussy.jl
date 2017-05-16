"""
    blanket_thickness(mag_max, P_W)

Lorem ipsum dolor sit amet.
"""
function blanket_thickness(mag_max, P_W)

  cur_a = 7.51e-08
  cur_b = -0.1539

  cur_neutron_source_rate = neutron_source_rate(P_W)

  # mag_max is from magnet team and is in neutrons / m^2

  # max neutrons / m^2 /s
  mag_max_flux = mag_max
  mag_max_flux /= Tokamak.T_k
  mag_max_flux /= 3.154e7

  # n / SourceN-cm^2
  max_N_per_source_N = mag_max_flux
  max_N_per_source_N /= cur_neutron_source_rate
  max_N_per_source_N /= 1e4

  cur_blanket_thickness = max_N_per_source_N
  cur_blanket_thickness /= cur_a
  cur_blanket_thickness = log(cur_blanket_thickness)
  cur_blanket_thickness /= cur_b

  cur_blanket_thickness = max(0, cur_blanket_thickness)

end
