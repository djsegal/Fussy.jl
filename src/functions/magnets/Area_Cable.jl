"""
    Area_Cable()

Area of total cable.
"""
function Area_Cable()

  cur_Area_Cable = Area_Cu()

  cur_Area_Cable += Area_HTS()

  cur_Area_Cable += Area_H2()

  cur_Area_Cable += Area_St()

  cur_Area_Cable

end
