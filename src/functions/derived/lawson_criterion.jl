"""
    lawson_criterion()

Lorem ipsum dolor sit amet.
"""
function lawson_criterion()
  cur_power_balance = power_balance() / 1u"MW"

  cur_tau_E = Sym("tau_E")

  solved_system = SymPy.solve(cur_power_balance, cur_tau_E)

  cur_lawson_criterion = solved_system[1]
  cur_lawson_criterion *= Sym("n_bar")

  cur_lawson_criterion
end
