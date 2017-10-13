"""
    evaluate_given_equations(main_value, side_guess, cur_eta_CD, initial_primary_constraint, initial_secondary_constraint, verbose=true)

Lorem ipsum dolor sit amet.
"""
function evaluate_given_equations(main_value, side_guess, cur_eta_CD, initial_primary_constraint, initial_secondary_constraint, verbose=true)
  cur_primary_constraint = initial_primary_constraint

  cur_secondary_constraints = collect(keys(Tokamak.constraint_params))

  filter!(
    x -> (
      x != cur_primary_constraint &&
      x != initial_secondary_constraint
    ),
    cur_secondary_constraints
  )

  unshift!(cur_secondary_constraints, initial_secondary_constraint)

  if !enable_secondary_constraint
    cur_secondary_constraints = [initial_secondary_constraint]
  end

  cur_solved_equation, cur_secondary_constraint, has_solution, worst_constraint =
    _evaluate_given_equations_deep(
      main_value, side_guess, cur_eta_CD,
      cur_primary_constraint,
      cur_secondary_constraints,
      verbose
    )

  if ( has_solution && worst_constraint == "x" )
    cur_solved_equation["primary_constraint"] = cur_primary_constraint
    cur_solved_equation["secondary_constraint"] = cur_secondary_constraint
    return cur_solved_equation
  end

  if !has_solution
    worst_constraint = initial_secondary_constraint
  end

  possible_constraints = collect(keys(Tokamak.constraint_params))

  filter!(
    x -> (
      x != cur_primary_constraint &&
      x != worst_constraint
    ),
    possible_constraints
  )

  unshift!(possible_constraints, worst_constraint)

  if !enable_primary_constraint
    possible_constraints = []
  end

  while length(possible_constraints) > 1

    cur_primary_constraint = shift!(possible_constraints)

    cur_solved_equation, cur_secondary_constraint, has_solution, worst_constraint =
      _evaluate_given_equations_deep(
        main_value, side_guess, cur_eta_CD,
        cur_primary_constraint,
        possible_constraints,
        verbose
      )

    if !has_solution ; continue ; end

    if worst_constraint == "x" ; break ; end

    filter!(
      x -> ( x != worst_constraint ),
      possible_constraints
    )

    unshift!(possible_constraints, worst_constraint)

  end

  if has_solution && worst_constraint == "x"
    cur_solved_equation["primary_constraint"] = cur_primary_constraint
    cur_solved_equation["secondary_constraint"] = cur_secondary_constraint
    return cur_solved_equation
  end

  for cur_key in keys(cur_solved_equation["limits"])
    cur_solved_equation["limits"][cur_key] = NaN
  end

  cur_solved_equation["R_0"] = NaN
  cur_solved_equation["B_0"] = NaN
  cur_solved_equation["T_k"] = NaN

  cur_solved_equation["rho_j"] = NaN
  cur_solved_equation["eta_CD"] = NaN

  cur_solved_equation["success"] = false

  cur_solved_equation["primary_constraint"] = "x"
  cur_solved_equation["secondary_constraint"] = "x"

  return cur_solved_equation

end

function _evaluate_given_equations_shallow(main_value, side_guess, cur_eta_CD, cur_constraint_list, verbose)

  worst_constraint = "x"

  has_solution = false

  given_equations = setup_given_equations(cur_constraint_list...)

  cur_solved_equation = solve_given_equation(main_value, given_equations, side_guess, verbose=verbose, eta_CD_guess=cur_eta_CD)

  if isnan(cur_solved_equation["eta_CD"])
    return cur_solved_equation, has_solution, worst_constraint
  end

  has_solution = true

  worst_value = max(
    1.0,
    cur_solved_equation["limits"][cur_constraint_list[1]],
    cur_solved_equation["limits"][cur_constraint_list[2]]
  )

  for (cur_key, cur_value) in cur_solved_equation["limits"]
    if cur_value < 0
      has_solution = false
      worst_constraint = "x"
      break
    end

    if any(x -> x == cur_key, cur_constraint_list); continue ; end
    if cur_value < worst_value ; continue ; end

    worst_constraint = cur_key
    worst_value = cur_value
  end

  return cur_solved_equation, has_solution, worst_constraint

end

function _evaluate_given_equations_deep(main_value, side_guess, cur_eta_CD, cur_primary_constraint, cur_secondary_constraints, verbose)
  cur_secondary_constraint = nothing
  cur_solved_equation = nothing
  has_solution = false
  worst_constraint = "x"

  for cur_secondary_constraint in cur_secondary_constraints
    cur_solved_equation, has_solution, worst_constraint =
      _evaluate_given_equations_shallow(
        main_value, side_guess, cur_eta_CD,
        [
          cur_primary_constraint,
          cur_secondary_constraint
        ],
        verbose
      )

    if has_solution ; break ; end
  end

  if has_solution && worst_constraint == "x"
    return cur_solved_equation, cur_secondary_constraint, has_solution, worst_constraint
  end

  if worst_constraint != "x"
    cur_secondary_constraint = worst_constraint

    cur_solved_equation, has_solution, worst_constraint =
      _evaluate_given_equations_shallow(
        main_value, side_guess, cur_eta_CD,
        [
          cur_primary_constraint,
          cur_secondary_constraint
        ],
        verbose
      )

    if !has_solution
      if enable_hard_errors
        throw("Improperly handled secondary constraint")
      else
        println("Error: Improperly handled secondary constraint:\n")
        print_workspace()
        println("\n--------------------------\n\n")
      end
    end
  end

  return cur_solved_equation, cur_secondary_constraint, has_solution, worst_constraint

end
