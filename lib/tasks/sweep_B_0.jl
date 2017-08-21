"""
    sweep_B_0(B_list, T_guess=15.0; verbose=true)

Lorem ipsum dolor sit amet.
"""
function sweep_B_0(B_list, T_guess=15.0; verbose=true)

  given_equations = setup_given_equations()

  load_input( "beta_N = $( max_beta_N )" )
  load_input( "P_W = $( max_P_W ) * ( 1u\"MW\" / 1u\"m^2\" )" )

  solved_equations = OrderedDict()

  solved_equations["R_0"] = Array{Float64}(length(B_list))
  solved_equations["T_k"] = Array{Float64}(length(B_list))

  solved_equations["rho_j"] = Array{Float64}(length(B_list))
  solved_equations["eta_CD"] = Array{Float64}(length(B_list))

  for cur_val in values(solved_equations)
    fill!(cur_val, NaN)
  end

  solved_equations["B_0"] = [B_list...]

  solved_equations["success"] = Array{Bool}(length(B_list))

  fill!(solved_equations["success"], false)

  solved_equations["constraint"] = Array{AbstractString}(length(B_list))

  fill!(solved_equations["constraint"], "x")

  solved_equations["limits"] = OrderedDict()

  for cur_key in keys(given_equations)
    solved_equations["limits"][cur_key] = Array{Float64}(length(B_list))
    fill!(solved_equations["limits"][cur_key], NaN)
  end

  cur_constraint = ( main_constraint == "x" ) ? default_constraint : main_constraint

  cur_eta_CD = default_eta_CD

  _sweep_B_0(given_equations, solved_equations, B_list, 1:length(B_list), T_guess, cur_constraint, cur_eta_CD, verbose, is_initial_run=true)

  if all(x -> isnan(x), solved_equations["eta_CD"])
    return solved_equations
  end

  has_seen_number = false

  for cur_index in length(B_list):-1:1
    if !has_seen_number && isnan(solved_equations["eta_CD"][cur_index])
      continue
    end

    if !isnan(solved_equations["eta_CD"][cur_index])
      has_seen_number = true
      continue
    end

    _sweep_B_0(given_equations, solved_equations, B_list, cur_index, solved_equations["T_k"][cur_index+1], solved_equations["constraint"][cur_index+1], solved_equations["eta_CD"][cur_index+1], verbose)

    if isnan(solved_equations["eta_CD"][cur_index])
      break
    end
  end

  has_seen_number = false

  for cur_index in 1:+1:length(B_list)
    if !has_seen_number && isnan(solved_equations["eta_CD"][cur_index])
      continue
    end

    if !isnan(solved_equations["eta_CD"][cur_index])
      has_seen_number = true
      continue
    end

    _sweep_B_0(given_equations, solved_equations, B_list, cur_index, solved_equations["T_k"][cur_index-1], solved_equations["constraint"][cur_index-1], solved_equations["eta_CD"][cur_index-1], verbose)

    if isnan(solved_equations["eta_CD"][cur_index])
      break
    end
  end

  return solved_equations

end

function _sweep_B_0(given_equations, solved_equations, B_list, cur_range, T_guess, cur_constraint, cur_eta_CD, verbose; is_left_branch=false, has_bad_parent=false, is_initial_run=false)

  if length(cur_range) == 0 ; return true ; end

  B_length = length(B_list[cur_range])

  cur_index = ( first(cur_range) - 1 ) + Int( ceil( B_length / 2 ) )

  cur_B = B_list[cur_index]

  if verbose ; print("\n\n$cur_B\n") ; end

  cur_solved_equation = solve_given_equation(cur_B, given_equations, T_guess, verbose=verbose, cur_constraint=cur_constraint, cur_eta_CD=cur_eta_CD)

  initial_constraint = nothing

  skip_search = main_constraint != "x"

  if !skip_search && isnan(cur_solved_equation["eta_CD"])
    for tmp_constraint in [cur_key for cur_key in keys(cur_solved_equation["limits"])]
      if tmp_constraint == cur_constraint
        continue
      end

      cur_solved_equation = solve_given_equation(cur_B, given_equations, T_guess, verbose=verbose, cur_constraint=tmp_constraint, cur_eta_CD=cur_eta_CD)

      if !isnan(cur_solved_equation["eta_CD"])
        initial_constraint = cur_constraint
        cur_constraint = tmp_constraint
        break
      end
    end

    if initial_constraint == nothing
      cur_constraint = nothing
    end
  end

  if cur_constraint == nothing
    new_constraint = nothing
  else
    new_constraint = collect(keys(cur_solved_equation["limits"]))[indmax(collect(values(cur_solved_equation["limits"])))]
  end

  if !skip_search && new_constraint != cur_constraint && new_constraint != initial_constraint
    cur_constraint = new_constraint

    cur_solved_equation = solve_given_equation(cur_B, given_equations, T_guess, verbose=verbose, cur_constraint=cur_constraint, cur_eta_CD=cur_eta_CD)

    new_constraint = collect(keys(cur_solved_equation["limits"]))[indmax(collect(values(cur_solved_equation["limits"])))]
  end

  if skip_search
    if isnan(cur_solved_equation["eta_CD"])
      new_constraint = nothing
    else
      new_constraint = cur_constraint
    end
  end

  if new_constraint != cur_constraint || new_constraint == initial_constraint
    println("Unable to satisfy all constraints:")

    cur_constraint = nothing

    for cur_key in keys(cur_solved_equation["limits"])
      cur_solved_equation["limits"][cur_key] = NaN
    end

    cur_solved_equation["R_0"] = NaN
    cur_solved_equation["T_k"] = NaN
    cur_solved_equation["rho_j"] = NaN
    cur_solved_equation["eta_CD"] = NaN

    cur_solved_equation["success"] = false
  end

  if cur_constraint == nothing
    cur_constraint = ( main_constraint == "x" ) ? default_constraint : main_constraint
  else
    solved_equations["constraint"][cur_index] = cur_constraint
  end

  solved_equations["R_0"][cur_index] = cur_solved_equation["R_0"]
  solved_equations["B_0"][cur_index] = cur_solved_equation["B_0"]
  solved_equations["T_k"][cur_index] = cur_solved_equation["T_k"]

  solved_equations["rho_j"][cur_index] = cur_solved_equation["rho_j"]
  solved_equations["eta_CD"][cur_index] = cur_solved_equation["eta_CD"]

  solved_equations["success"][cur_index] = cur_solved_equation["success"]

  for (sub_key, sub_value) in given_equations
    solved_equations["limits"][sub_key][cur_index] = cur_solved_equation["limits"][sub_key]
  end

  is_successful_run = !isnan(solved_equations["T_k"][cur_index])

  if length(cur_range) == 1
    return is_successful_run
  end

  if is_successful_run
    T_guess = solved_equations["T_k"][cur_index]
    cur_eta_CD = solved_equations["eta_CD"][cur_index]
  end

  beg_range = first(cur_range):(cur_index-1)
  end_range = (cur_index+1):last(cur_range)

  left_is_left = true
  right_is_left = false

  if !is_successful_run && !is_initial_run
    if has_bad_parent
      if is_left_branch
        end_range = 0:-1
      else
        beg_range = 0:-1
      end
    else
      left_is_left = !is_left_branch
      right_is_left = is_left_branch

      if is_left_branch
        beg_range = 0:-1
      else
        end_range = 0:-1
      end
    end
  end

  if !is_successful_run
    if length(beg_range) == 0
      good_beg_value = false
    else
      good_beg_value = _sweep_B_0(
        given_equations, solved_equations, B_list, first(beg_range),
        T_guess, cur_constraint, cur_eta_CD, verbose,
        is_left_branch=left_is_left, has_bad_parent=!is_successful_run
      )
    end

    if good_beg_value
      beg_range = (first(beg_range)+1):last(beg_range)
    else
      beg_range = 0:-1
    end
  end

  if !is_successful_run
    if length(end_range) == 0
      good_end_value = false
    else
      good_end_value = _sweep_B_0(
        given_equations, solved_equations, B_list, last(end_range),
        T_guess, cur_constraint, cur_eta_CD, verbose,
        is_left_branch=right_is_left, has_bad_parent=!is_successful_run
      )
    end

    if good_end_value
      end_range = first(end_range):(last(end_range)-1)
    else
      end_range = 0:-1
    end
  end

  _sweep_B_0(given_equations, solved_equations, B_list, beg_range, T_guess, cur_constraint, cur_eta_CD, verbose, is_left_branch=left_is_left, has_bad_parent=!is_successful_run)
  _sweep_B_0(given_equations, solved_equations, B_list, end_range, T_guess, cur_constraint, cur_eta_CD, verbose, is_left_branch=right_is_left, has_bad_parent=!is_successful_run)

  return is_successful_run

end
