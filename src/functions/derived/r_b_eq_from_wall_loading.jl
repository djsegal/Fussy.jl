"""
    r_b_eq_from_wall_loading()

Lorem ipsum dolor sit amet.
"""
function r_b_eq_from_wall_loading()
  cur_wall_loading = wall_loading_limit() / 1u"MW"

  cur_R_0 = symbol_dict["R_0"]

  cur_n_bar = simplified_density()
  cur_n_bar /= 1u"n20"

  cur_wall_loading = subs( cur_wall_loading , symbol_dict["n_bar"] , cur_n_bar )

  solved_system = SymPy.solve(cur_wall_loading, cur_R_0)

  cur_r_b_eq = solved_system[1]

  cur_r_b_eq -= cur_R_0

  cur_r_b_eq
end
