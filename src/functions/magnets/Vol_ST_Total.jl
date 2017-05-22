"""
    Vol_ST_Total(cur_solution=solve_magnet_equations())

Lorem ipsum dolor sit amet.
"""
function Vol_ST_Total(cur_solution=solve_magnet_equations())

  cur_Vol_ST_Total = VJ_CS(cur_solution)

  cur_Vol_ST_Total += sum(Vsc_PF())

  cur_Vol_ST_Total *= ( 1 - magnet_hts_fraction )

  cur_Vol_ST_Total += VM_CS(cur_solution)

  cur_Vol_ST_Total += sum(Vst_PF())

  cur_Vol_ST_Total += V_TF()

  cur_Vol_ST_Total += Vol_WP() * ( 1 - Frac_HTS() )

  cur_Vol_ST_Total

end
