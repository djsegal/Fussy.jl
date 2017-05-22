"""
    Vol_HTS_Total(cur_solution=solve_magnet_equations())

Lorem ipsum dolor sit amet.
"""
function Vol_HTS_Total(cur_solution=solve_magnet_equations())

  cur_Vol_HTS_Total = VJ_CS(cur_solution)

  cur_Vol_HTS_Total += sum( Vsc_PF() )

  cur_Vol_HTS_Total *= Tokamak.magnet_hts_fraction

  cur_Vol_HTS_Total += Tokamak.Vol_WP() * Tokamak.Frac_HTS()

  cur_Vol_HTS_Total

end
