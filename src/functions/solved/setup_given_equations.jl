"""
    setup_given_equations(cur_primary_constraint, cur_secondary_constraint)

Lorem ipsum dolor sit amet.
"""
function setup_given_equations(cur_primary_constraint, cur_secondary_constraint)

  constraint_list = [cur_primary_constraint, cur_secondary_constraint]

  cur_given_equations = make_given_equations(constraint_list...)

  expand_given_equations!(
    cur_given_equations,
    constraint_list...
  )

  cur_given_equations

end
