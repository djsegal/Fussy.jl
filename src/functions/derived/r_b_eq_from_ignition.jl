"""
    r_b_eq_from_ignition()

Lorem ipsum dolor sit amet.
"""
function r_b_eq_from_ignition()
  cur_ignition_requirement = ignition_requirement()

  cur_R_0 = symbol_dict["R_0"]

  solved_system = SymPy.solve(cur_ignition_requirement, cur_R_0)

  r_b_eq = solved_system[1]

  println(simplify(r_b_eq))

  cur_ignition_requirement
end
