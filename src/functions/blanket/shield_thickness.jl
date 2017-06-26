"""
    shield_thickness(cur_R_0=R_0, cur_n_bar=n_bar, cur_I_M=I_M)

Lorem ipsum dolor sit amet.
"""
function shield_thickness(cur_R_0=R_0, cur_n_bar=n_bar, cur_I_M=I_M)

  cur_a = 7.51e-8 * 1u"cm^-2"
  cur_b = -0.1539 * 1u"cm^-1"

  cur_P_W = calc_possible_values(
    ( wall_loading_limit() + P_W ) / ( 1u"MW" / 1u"m^2" )
  )

  cur_P_W *= 1e6 # MW to W

  seconds_in_a_year = 3.154e7 * 1u"s"

  cur_neutron_source_rate = neutron_source_rate(cur_P_W) # [1/s]

  # max flux: neutrons / m^2 /s

  mag_max_flux = magnet_max_neutron_fluence
  mag_max_flux /= plant_life # in years
  mag_max_flux /= seconds_in_a_year

  # n / SourceN-cm^2
  max_N_per_source_N = mag_max_flux
  max_N_per_source_N /= cur_neutron_source_rate

  max_N_per_source_N = uconvert(u"cm^-2", max_N_per_source_N)

  cur_shield_thickness = max_N_per_source_N
  cur_shield_thickness /= cur_a

  cur_shield_thickness = log( cur_shield_thickness )

  cur_shield_thickness /= cur_b

  cur_shield_thickness = uconvert(u"m", cur_shield_thickness)

  cur_shield_thickness /= 1u"m"

  cur_shield_thickness = max(cur_shield_thickness, 0)

  has_actual_values = eltype(cur_R_0 / 1u"m") != SymPy.Sym
  has_actual_values &= eltype(cur_n_bar / 1u"n20") != SymPy.Sym
  has_actual_values &= eltype(cur_I_M / 1u"MA") != SymPy.Sym

  if has_actual_values
    cur_shield_thickness = magnet_subs(
      cur_shield_thickness,
      cur_R_0, cur_n_bar, cur_I_M
    )
  end

  cur_shield_thickness *= 1u"m"

  cur_shield_thickness

end