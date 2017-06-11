@doc """
    Cable_L(cur_R_0=R_0, cur_n_bar=n_bar, cur_I_M=I_M)

Length of one cable [m].
"""
@memoize function Cable_L(cur_R_0=R_0, cur_n_bar=n_bar, cur_I_M=I_M)

  cur_Cable_L = WP_d()

  cur_Cable_L *= Coil_P(cur_R_0, cur_n_bar, cur_I_M)

  cur_Cable_L

end
