"""
    expand_given_equations!(cur_given_equations, cur_primary_constraint, cur_secondary_constraint)

Lorem ipsum dolor sit amet.
"""
function expand_given_equations!(cur_given_equations, cur_primary_constraint, cur_secondary_constraint)

  for cur_constraint in [cur_primary_constraint, cur_secondary_constraint]
    cur_index = first(find(x -> x == cur_constraint, keys(constraint_params)))

    cur_G = getfield( Tokamak, Symbol("G_$(cur_index)") )
    cur_K = getfield( Tokamak, Symbol("K_$(cur_index)") )

    cur_G_K = cur_G() * cur_K()

    for (cur_key, cur_value) in cur_given_equations
      cur_given_equations[cur_key] = subs(
        cur_value,
        symbol_dict["G_K_$(cur_index)"],
        cur_G_K
      )
    end
  end

  cur_given_equations

end
