"""
    Cryoplant_Cost()

Cost of cryoplant scaled to various heat loads, scaled to 4.5K and estimated using Green's Formula.
"""
function Cryoplant_Cost()
  (2.6*10^6*(econ_Q_total())^0.63)
end
