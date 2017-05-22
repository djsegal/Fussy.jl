"""
    Cryostat_Cost()

Cost of cryostat scaled to ITER.
"""
function Cryostat_Cost()
  (75.8*10^6)*((1+kappa^2)*( R_0 / 1u"m" )*( a() / 1u"m" ))/48.2
end
