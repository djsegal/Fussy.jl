"""
    simplified_density()

Lorem ipsum dolor sit amet.
"""
function simplified_density()
  eq_1 = greenwald_limit()
  eq_2 = steady_state()

  cur_n_bar = Sym("n_bar")
  cur_I_M = Sym("I_M")

  solved_system = SymPy.solve([eq_1, eq_2], [cur_n_bar, cur_I_M])
  solved_system[1][cur_n_bar]
end
