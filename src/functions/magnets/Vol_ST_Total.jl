"""
    Vol_ST_Total()

Lorem ipsum dolor sit amet.
"""
function Vol_ST_Total()
  (VM_CS() + (sum(Vst_PF())) + (sum(Vsc_PF())*(1-Tokamak.magnet_hts_fraction)) + VJ_CS()*(1-Tokamak.magnet_hts_fraction) + Tokamak.V_TF() + Tokamak.Vol_WP()*(1-Tokamak.Frac_HTS()))
end
