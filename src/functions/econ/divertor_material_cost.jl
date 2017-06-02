"""
    divertor_material_cost()

Heating due to thermal shielding @ 80K [kW].
"""
function divertor_material_cost()

  # Volume Tungsten

  div_mat_c = V_w_fl() # (in Flibe channel)

  div_mat_c += V_w_c() # (in cooling)

  div_mat_c *= cost_W

  # Volume Inconel

  div_mat_c += V_inconel() * cost_inconel

  # Volume Steel

  div_mat_c += econ_V_steel() * cost_steel

  div_mat_c

end
