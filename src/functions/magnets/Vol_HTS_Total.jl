@doc """
    Vol_HTS_Total(cur_R_0=R_0, cur_n_bar=n_bar, cur_I_M=I_M; cur_solution=solve_magnet_equations())

Lorem ipsum dolor sit amet.
"""
@memoize function Vol_HTS_Total(cur_R_0=R_0, cur_n_bar=n_bar, cur_I_M=I_M; cur_solution=solve_magnet_equations())

  cur_left_part = VJ_CS(cur_solution)

  cur_left_part += sum( Vsc_PF(cur_R_0, cur_n_bar, cur_I_M) )

  cur_left_part *= magnet_hts_fraction

  cur_right_part = Vol_WP(cur_R_0, cur_n_bar, cur_I_M)

  cur_right_part *= Frac_HTS(cur_R_0, cur_n_bar, cur_I_M)

  cur_Vol_HTS_Total = cur_left_part + cur_right_part

  cur_Vol_HTS_Total

end
