"""
    econ_Q_total()

Total cooling equivalent at 4.5 K to use in Green formula [kW].
"""
function econ_Q_total()

  # equivalent cooling powers at 4.5K [kW]

  Q_eq1 = econ_Q_15()
  Q_eq1 /= 3.47

  Q_eq2 = econ_Q_80()
  Q_eq2 /= 24

  Q_total = Q_eq1 + Q_eq2

end
