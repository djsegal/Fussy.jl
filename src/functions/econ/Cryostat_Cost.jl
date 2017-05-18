"""
    Cryostat_Cost()

Cost of cryostat scaled to ITER.
"""
function Cryostat_Cost()
  (75.8*10^6)*((1+Tokamak.kappa^2)*( Tokamak.R_0 / 1u"m" )*( Tokamak.a() / 1u"m" ))/48.2
end
