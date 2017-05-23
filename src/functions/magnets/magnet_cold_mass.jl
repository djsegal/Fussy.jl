"""
    magnet_cold_mass(cur_solution=solve_magnet_equations())

Total volume of magnets times density (~8000 kg/m3) in [tons].
"""
function magnet_cold_mass(cur_solution=solve_magnet_equations())

  if !enable_cold_mass_calc
    return magnet_standard_cold_mass
  end

  cur_cold_mass = Vol_ST_Total(cur_solution)

  cur_cold_mass += Vol_HTS_Total(cur_solution)

  cur_cold_mass *= St_Rho

  cur_cold_mass *= 1e-3

  cur_cold_mass

end
