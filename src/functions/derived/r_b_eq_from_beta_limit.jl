"""
    r_b_eq_from_beta_limit()

Lorem ipsum dolor sit amet.
"""
function r_b_eq_from_beta_limit()
  cur_beta_limit = troyon_beta_limit()

  cur_R_0 = symbol_dict["R_0"]

  cur_I_M = simplified_current()
  cur_n_bar = simplified_density()

  cur_I_M /= 1u"MA"
  cur_n_bar /= 1u"n20"

  cur_beta_limit = subs( cur_beta_limit , symbol_dict["n_bar"] , cur_n_bar )
  cur_beta_limit = subs( cur_beta_limit , symbol_dict["I_M"] , cur_I_M )

  solved_system = SymPy.solve(cur_beta_limit, cur_R_0)

  cur_r_b_eq = solved_system[1]

  cur_r_b_eq -= cur_R_0

  cur_r_b_eq
end
