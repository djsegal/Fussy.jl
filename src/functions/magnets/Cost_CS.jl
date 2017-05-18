"""
    Cost_CS()

Lorem ipsum dolor sit amet.
"""
function Cost_CS()
  Tokamak.Price_St*(VM_CS()+(1-Tokamak.magnet_hts_fraction)*VJ_CS())*8000 + Tokamak.magnet_hts_fraction*VJ_CS()*(Tokamak.Price_HTS/Tokamak.Area_Tape())
end
