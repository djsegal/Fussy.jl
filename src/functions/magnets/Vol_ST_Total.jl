"""
    Vol_ST_Total(cur_R_0=R_0, cur_n_bar=n_bar, cur_I_M=I_M; cur_solution=solve_magnet_equations())

Lorem ipsum dolor sit amet.
"""
function Vol_ST_Total(cur_R_0=R_0, cur_n_bar=n_bar, cur_I_M=I_M; cur_solution=solve_magnet_equations())

  cur_first_part = VJ_CS(cur_solution)

  cur_first_part += sum(Vsc_PF())

  cur_first_part *= ( 1 - magnet_hts_fraction )

  cur_second_part = VM_CS(cur_solution)

  cur_second_part += sum(Vst_PF())

  cur_Frac_HTS = Frac_HTS(cur_R_0, cur_n_bar, cur_I_M)

  cur_third_part = Vol_WP(cur_R_0, cur_n_bar, cur_I_M)

  cur_third_part *= ( 1 - cur_Frac_HTS )

  cur_third_part += V_TF(cur_R_0, cur_n_bar, cur_I_M)

  cur_Vol_ST_Total = cur_first_part

  cur_Vol_ST_Total += cur_second_part

  cur_Vol_ST_Total += cur_third_part

  cur_Vol_ST_Total

end
