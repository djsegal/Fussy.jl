"""
    r_b_eq_from_ignition()

Lorem ipsum dolor sit amet.
"""
function r_b_eq_from_ignition()
  cur_ignition_requirement = ignition_requirement()

  cur_R_0 = symbol_dict["R_0"]

  solved_system = SymPy.solve(cur_ignition_requirement, cur_R_0)

  # --------------------------
  #  hack to get answer (beg)
  # --------------------------

  cur_r_b_eq = norm(solved_system)

  cur_r_b_eq *= abs( K_PB() / 0.654 ) ^ ( 100 // 16 )

  # --------------------------
  #  hack to get answer (end)
  # --------------------------

  cur_r_b_eq
end
