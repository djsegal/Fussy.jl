"""
    Vol_ST_Total(cur_solution=solve_magnet_equations())

Lorem ipsum dolor sit amet.
"""
function Vol_ST_Total(cur_solution=solve_magnet_equations())

  cur_Vol_ST_Total = VJ_CS(cur_solution)

  cur_Vol_ST_Total += sum(Vsc_PF())

  cur_Vol_ST_Total *= ( 1 - Tokamak.magnet_hts_fraction )

  cur_Vol_ST_Total += VM_CS(cur_solution)

  cur_Vol_ST_Total += sum(Vst_PF())

  cur_Vol_ST_Total += Tokamak.V_TF()

  cur_Vol_ST_Total += Tokamak.Vol_WP() * ( 1 - Tokamak.Frac_HTS() )

  cur_Vol_ST_Total

end
