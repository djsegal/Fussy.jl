"""
    Cryo_Operation()

Cost of power @ 0.1 \$/kWhr to power the cryoplant annually.
"""
function Cryo_Operation()
  (econ_Q_total()/(15/(300-15)))/(0.141*econ_Q_total()^0.26)*(365*24)*(0.1)*1.08
end
