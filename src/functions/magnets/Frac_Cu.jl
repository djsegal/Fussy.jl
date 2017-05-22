"""
    Frac_Cu()

Fraction of copper.
"""
function Frac_Cu()

  cur_Frac = Area_Cu()

  cur_Frac /= Area_Cable()

  cur_Frac

end
