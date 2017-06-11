@doc """
    C_TF()

Lorem ipsum dolor sit amet.
"""
@memoize function C_TF()

  cur_C_TF = V_TF()

  cur_C_TF *= Price_St

  cur_C_TF *= St_Rho

  cur_C_TF

end
