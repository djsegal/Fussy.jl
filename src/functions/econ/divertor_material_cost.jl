"""
    divertor_material_cost()

Heating due to thermal shielding @ 80K [kW].
"""
function divertor_material_cost()
  div_mat_c = 0.0

  #Volume tungsten in cooling
  div_mat_c += V_w_c() * cost_W

  #Volume Steel
  div_mat_c += econ_V_steel() * cost_steel

  #Flibe channel tungsten
  div_mat_c += V_w_fl() * cost_W

  # %volume inconel
  div_mat_c += V_inconel() * cost_inconel

  div_mat_c
end
