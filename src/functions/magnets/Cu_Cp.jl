"""
    Cu_Cp(T)

Specific heat of copper as func of temperature.
"""
function Cu_Cp(T)

  cur_Cu_Cp = 0.0

  cur_Cu_Cp -= 0.076191481557999 * T

  cur_Cu_Cp -= 0.003303875802231 * T ^ 2

  cur_Cu_Cp += 0.001659188093121 * T ^ 3

  cur_Cu_Cp -= 0.000015917952141 * T ^ 4

  cur_Cu_Cp

end
