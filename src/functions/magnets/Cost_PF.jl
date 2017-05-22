"""
    Cost_PF()

Lorem ipsum dolor sit amet.
"""
function Cost_PF()

  cur_Vsc_PF = Vsc_PF()

  cur_left_term = magnet_hts_fraction

  cur_left_term *= sum( cur_Vsc_PF )

  cur_left_term *= Price_HTS

  cur_left_term /= Area_Tape()

  cur_right_term = ( 1 - magnet_hts_fraction )

  cur_right_term *= sum( cur_Vsc_PF )

  cur_right_term += sum( Vst_PF() )

  cur_right_term *= Price_St

  cur_right_term *= 8000

  cur_Cost_PF = cur_left_term + cur_right_term

  cur_Cost_PF

end
