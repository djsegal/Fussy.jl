"""
    simplified_current()

Lorem ipsum dolor sit amet.
"""
function simplified_current()
  eq_1 = greenwald_limit()
  eq_2 = steady_state()

  cur_I_M = symbol_dict["I_M"]
  cur_n_bar = symbol_dict["n_bar"]

  solved_system = SymPy.solve([eq_1, eq_2], [cur_I_M, cur_n_bar])

  cur_simplified_current = solved_system[1][cur_I_M]
  cur_simplified_current *= 1u"MA"

  cur_simplified_current
end
