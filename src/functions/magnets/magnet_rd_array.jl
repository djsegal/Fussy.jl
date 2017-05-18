"""
    magnet_rd_array()

Lorem ipsum dolor sit amet.
"""
function magnet_rd_array()
  r1 = ( R_0 / 1u"m" )-( a() / 1u"m" )*(0.709*kappa+delta)
  r2 = ( R_0 / 1u"m" )+( a() / 1u"m" )*(0.962*kappa-delta)
  r3 = ( R_0 / 1u"m" )+( a() / 1u"m" )*(0.962*kappa-delta)
  r4 = ( R_0 / 1u"m" )-( a() / 1u"m" )*(0.709*kappa+delta)
  r5 = ( R_0 / 1u"m" )+( a() / 1u"m" )*(0.962*kappa-delta)
  r6 = ( R_0 / 1u"m" )+( a() / 1u"m" )*(0.962*kappa-delta)

  rd = [r1 r6 r2 r5 r3 r4]

  rd
end
