"""
    Vol_HTS_Total(cur_solution=solve_magnet_equations())

Lorem ipsum dolor sit amet.
"""
function Vol_HTS_Total(cur_solution=solve_magnet_equations())

  cur_Vol_HTS_Total = VJ_CS(cur_solution)

  cur_Vol_HTS_Total += sum( Vsc_PF() )

  cur_Vol_HTS_Total *= magnet_hts_fraction

  cur_Vol_HTS_Total += Vol_WP() * Frac_HTS()

  cur_Vol_HTS_Total

end
