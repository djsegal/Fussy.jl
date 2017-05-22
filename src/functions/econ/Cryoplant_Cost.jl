"""
    Cryoplant_Cost()

Cost of cryoplant scaled to various heat loads, scaled to 4.5K and estimated using Green's Formula.
"""
function Cryoplant_Cost()

  cur_Cryoplant_Cost = 2.6e6

  cur_Cryoplant_Cost *= magnet_Q_total() ^ 0.63

  cur_Cryoplant_Cost

end
