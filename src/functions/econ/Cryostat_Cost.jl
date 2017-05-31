"""
    Cryostat_Cost()

Cost of cryostat scaled to ITER.
"""
function Cryostat_Cost()

  cur_Cryostat_Cost = 75.8e6

  cur_Cryostat_Cost *= 1 + kappa ^ 2

  cur_Cryostat_Cost *= ( R_0 / 1u"m" )

  cur_Cryostat_Cost *= ( a() / 1u"m" )

  cur_Cryostat_Cost /= 48.2

  cur_Cryostat_Cost

end
