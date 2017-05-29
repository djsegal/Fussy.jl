"""
    blanket_thickness()

Total thickness of everything between plasma and magnets, ie:
first wall, vacuum vessel, flibe blanket, be multiplier, and shielding..
"""
function blanket_thickness()

  if !enable_blanket_derive
    return 1.19u"m"
  end

  blanket_thickness = 0.7258u"m"

  blanket_thickness += shield_thickness()

  blanket_thickness

end
