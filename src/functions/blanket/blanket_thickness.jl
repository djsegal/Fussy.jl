"""
    blanket_thickness(cur_R_0=R_0, cur_n_bar=n_bar, cur_I_M=I_M)

Total thickness of everything between plasma and magnets, ie:
first wall, vacuum vessel, flibe blanket, be multiplier, and shielding..
"""
function blanket_thickness(cur_R_0=R_0, cur_n_bar=n_bar, cur_I_M=I_M)

  if !enable_blanket_derive
    return 1.19u"m"
  end

  blanket_thickness = 0.7258u"m"

  blanket_thickness += shield_thickness(cur_R_0, cur_n_bar, cur_I_M)

  blanket_thickness

end
