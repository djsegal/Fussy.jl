"""
    econ_V_steel()

Lorem ipsum dolor sit amet.
"""
function econ_V_steel()
  cur_V_steel = 0.22

  cur_V_steel *= a() / 1u"m"
  cur_V_steel *= R_0 / 1u"m"

  cur_V_steel
end
