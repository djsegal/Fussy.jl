"""
    Cost_PF()

Lorem ipsum dolor sit amet.
"""
function Cost_PF()
  Tokamak.magnet_hts_fraction*sum(Vsc_PF())*(Tokamak.Price_HTS/Tokamak.Area_Tape()) + (((1-Tokamak.magnet_hts_fraction)*sum(Vsc_PF()))+sum(Vst_PF()))*Tokamak.Price_St*8000
end
