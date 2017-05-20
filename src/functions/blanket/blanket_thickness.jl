"""
    blanket_thickness()

Lorem ipsum dolor sit amet.
"""
function blanket_thickness()

  if !enable_blanket_derive
    return 0.89u"m"
  end

  blanket_thickness = 0.7258u"m"

  blanket_thickness += shield_thickness()

  blanket_thickness

end
