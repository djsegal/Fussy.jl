"""
    Vol_HTS_Total()

Lorem ipsum dolor sit amet.
"""
function Vol_HTS_Total()
  (VJ_CS()*Tokamak.magnet_hts_fraction+(sum(Vsc_PF())*Tokamak.magnet_hts_fraction)+Tokamak.Vol_WP()*Tokamak.Frac_HTS())
end
