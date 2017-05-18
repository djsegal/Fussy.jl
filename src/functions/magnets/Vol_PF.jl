"""
    Vol_PF()

Volume of PF Coils (HTS and Structure).
"""
function Vol_PF()
  sum(Vsc_PF()) + sum(Vst_PF())
end
