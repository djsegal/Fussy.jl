"""
    econ_MW_e()

power output of the plant in MW.
"""
function econ_MW_e()

  cur_econ_MW_e = thermal_power()

  cur_econ_MW_e *= eta_BOP

  cur_econ_MW_e

end
