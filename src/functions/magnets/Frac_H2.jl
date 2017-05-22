"""
    Frac_H2()

Fraction of H2.
"""
function Frac_H2()

  cur_Frac = Area_H2()

  cur_Frac /= Area_Cable()

  cur_Frac

end
