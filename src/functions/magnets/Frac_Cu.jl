@doc """
    Frac_Cu()

Fraction of copper.
"""
@memoize function Frac_Cu()

  cur_Frac = Area_Cu()

  cur_Frac /= Area_Cable()

  cur_Frac

end
