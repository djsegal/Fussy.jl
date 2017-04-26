"""
    r_b_eq_from_heat_loading()

Lorem ipsum dolor sit amet.
"""
function r_b_eq_from_heat_loading()
  cur_heat_load = heat_load_limit()

  cur_heat_load *= 1u"m"
  cur_heat_load /= ( 1u"MW" * 1u"T" )

  cur_R_0 = symbol_dict["R_0"]

  cur_n_bar = simplified_density()
  cur_n_bar /= 1u"n20"

  cur_heat_load = subs( cur_heat_load , symbol_dict["n_bar"] , cur_n_bar )

  solved_system = SymPy.solve(cur_heat_load, cur_R_0)

  cur_r_b_eq = solved_system[2]

  if !isreal(SymPy.N(coeff(cur_r_b_eq, symbol_dict["B_0"])))
    cur_r_b_eq = 0
  end

  cur_r_b_eq -= cur_R_0

  cur_r_b_eq
end
