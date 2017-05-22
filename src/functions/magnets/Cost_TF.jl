"""
    Cost_TF()

Lorem ipsum dolor sit amet.
"""
function Cost_TF()

  cur_Cost_TF = Cost_Tape()

  cur_Cost_TF += Cost_Cu()

  cur_Cost_TF += Cost_St()

  cur_Cost_TF *= magnet_num_coils

  cur_Cost_TF += C_TF()

  cur_Cost_TF

end
