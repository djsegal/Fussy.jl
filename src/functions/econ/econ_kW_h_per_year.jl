"""
    econ_kW_h_per_year()

Lorem ipsum dolor sit amet.
"""
function econ_kW_h_per_year()

  kW_h_per_year = econ_availability

  kW_h_per_year *= thermal_power()

  kW_h_per_year *= 1000 # kW in MW

  kW_h_per_year *= 3.15576e7 # seconds in year

  kW_h_per_year /= 3600 # seconds per hour

  kW_h_per_year

end
