"""
    make_given_equations(cur_primary_constraint, cur_secondary_constraint)

Lorem ipsum dolor sit amet.
"""
function make_given_equations(cur_primary_constraint, cur_secondary_constraint)

  cur_constraint_equations = OrderedDict()

  for cur_constraint in [cur_primary_constraint, cur_secondary_constraint]
    cur_index = first(find(x -> x == cur_constraint, keys(constraint_params)))
    cur_equation = eval(parse("R_B_$(cur_index)() - symbol_dict[\"G_K_$(cur_index)\"]"))

    cur_R_eq = first(elements(solveset(
      cur_equation,
      symbol_dict["R_0"],
      SymPy.S.Reals
    )))

    cur_constraint_equations[cur_constraint] = cur_R_eq
  end

  cur_given_equations = OrderedDict()

  if enable_radius_merging
    cur_given_equations["R_0"] = 0.5 * sum(
      collect(values(cur_constraint_equations))
    )
  else
    cur_given_equations["R_0"] = first(values(cur_constraint_equations))
  end

  cur_given_equations["B_0"] = first(elements(solveset(
    first(diff(collect(values(cur_constraint_equations)))),
    symbol_dict["B_0"],
    SymPy.S.Reals
  )))

  cur_given_equations

end
