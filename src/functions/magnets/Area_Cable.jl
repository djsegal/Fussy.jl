"""
    Area_Cable(cur_R_0=R_0, cur_n_bar=n_bar, cur_I_M=I_M)

Area of total cable.
"""
function Area_Cable(cur_R_0=R_0, cur_n_bar=n_bar, cur_I_M=I_M)

  cur_Area_Cable = Area_HTS()

  cur_Area_Cable += Area_St(cur_R_0, cur_n_bar, cur_I_M)

  cur_Area_Cable += Area_Cu(cur_R_0, cur_n_bar, cur_I_M)

  cur_Area_Cable += Area_H2(cur_R_0, cur_n_bar, cur_I_M)

  cur_Area_Cable

end
