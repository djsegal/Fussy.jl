"""
    Frac_HTS()

Fraction of HTS.
"""
function Frac_HTS()

  cur_Frac = Area_HTS()

  cur_Frac /= Area_Cable()

  cur_Frac

end
