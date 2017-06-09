"""
    Frac_HTS(cur_R_0=R_0, cur_n_bar=n_bar, cur_I_M=I_M)

Fraction of HTS.
"""
function Frac_HTS(cur_R_0=R_0, cur_n_bar=n_bar, cur_I_M=I_M)

  cur_Frac = Area_HTS()

  cur_Frac /= Area_Cable(cur_R_0, cur_n_bar, cur_I_M)

  cur_Frac

end
