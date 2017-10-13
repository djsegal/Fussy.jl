"""
    sweep_T_k(T_list; verbose=true)

Lorem ipsum dolor sit amet.
"""
function sweep_T_k(T_list; verbose=true)
  solved_equations = OrderedDict()

  solved_equations["R_0"] = Array{Float64}(length(T_list))
  solved_equations["B_0"] = Array{Float64}(length(T_list))

  solved_equations["rho_j"] = Array{Float64}(length(T_list))
  solved_equations["eta_CD"] = Array{Float64}(length(T_list))

  for cur_val in values(solved_equations)
    fill!(cur_val, NaN)
  end

  solved_equations["T_k"] = Array{Float64}(T_list)

  solved_equations["success"] = Array{Bool}(length(T_list))

  fill!(solved_equations["success"], false)

  solved_equations["primary_constraint"] = Array{AbstractString}(length(T_list))

  fill!(solved_equations["primary_constraint"], "x")

  solved_equations["secondary_constraint"] = Array{AbstractString}(length(T_list))

  fill!(solved_equations["secondary_constraint"], "x")

  solved_equations["limits"] = OrderedDict()

  for cur_key in keys(constraint_params)
    solved_equations["limits"][cur_key] = Array{Float64}(length(T_list))
    fill!(solved_equations["limits"][cur_key], NaN)
  end

  _sweep_T_k(
    solved_equations,
    T_list, 1:length(T_list),
    default_primary_constraint, default_secondary_constraint,
    verbose, is_initial_run=true
  )

  if enable_eta_CD_derive && any(x -> !isnan(x), solved_equations["eta_CD"])
    _resweep_side_T_k_s(solved_equations, T_list, verbose)
  end

  return solved_equations

end

function _sweep_T_k(solved_equations, T_list, cur_range, cur_primary_constraint, cur_secondary_constraint, verbose; is_left_branch=false, has_bad_parent=false, is_initial_run=false)

  if length(cur_range) == 0 ; return true ; end

  T_length = length(T_list[cur_range])

  cur_index = ( first(cur_range) - 1 ) + Int( ceil( T_length / 2 ) )

  main_value = T_list[cur_index]

  success_indices = find(solved_equations["success"])

  if length(success_indices) == 0
    side_guess = default_B_guess
    cur_eta_CD = default_eta_CD
  elseif length(success_indices) == 1
    side_guess = solved_equations["B_0"][success_indices[1]]
    cur_eta_CD = solved_equations["eta_CD"][success_indices[1]]
  else
    cur_B_0_grid = solved_equations["B_0"][success_indices]
    cur_T_k_grid = solved_equations["T_k"][success_indices]
    cur_eta_CD_grid = solved_equations["eta_CD"][success_indices]

    side_guess = Interpolations.interpolate((cur_T_k_grid,), cur_B_0_grid, Gridded(Linear()))[main_value]
    cur_eta_CD = Interpolations.interpolate((cur_T_k_grid,), cur_eta_CD_grid, Gridded(Linear()))[main_value]
  end

  if verbose ; print("\n\n$main_value\n") ; end

  cur_solved_equation = evaluate_given_equations(
    main_value,
    side_guess,
    cur_eta_CD,
    cur_primary_constraint,
    cur_secondary_constraint,
    verbose
  )

  solved_equations["R_0"][cur_index] = cur_solved_equation["R_0"]
  solved_equations["B_0"][cur_index] = cur_solved_equation["B_0"]
  # solved_equations["T_k"][cur_index] = cur_solved_equation["T_k"]

  solved_equations["rho_j"][cur_index] = cur_solved_equation["rho_j"]
  solved_equations["eta_CD"][cur_index] = cur_solved_equation["eta_CD"]

  solved_equations["success"][cur_index] = cur_solved_equation["success"]

  solved_equations["primary_constraint"][cur_index] = cur_solved_equation["primary_constraint"]
  solved_equations["secondary_constraint"][cur_index] = cur_solved_equation["secondary_constraint"]

  for cur_key in keys(constraint_params)
    solved_equations["limits"][cur_key][cur_index] = cur_solved_equation["limits"][cur_key]
  end

  is_successful_run = !isnan(solved_equations["B_0"][cur_index])

  if length(cur_range) == 1
    return is_successful_run
  end

  if is_successful_run
    cur_primary_constraint = cur_solved_equation["primary_constraint"]
    cur_secondary_constraint = cur_solved_equation["secondary_constraint"]
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
      good_beg_value = _sweep_T_k(
        solved_equations, T_list, first(beg_range),
        cur_primary_constraint, cur_secondary_constraint, verbose,
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
      good_end_value = _sweep_T_k(
        solved_equations, T_list, last(end_range),
        cur_primary_constraint, cur_secondary_constraint, verbose,
        is_left_branch=right_is_left, has_bad_parent=!is_successful_run
      )
    end

    if good_end_value
      end_range = first(end_range):(last(end_range)-1)
    else
      end_range = 0:-1
    end
  end

  _sweep_T_k(solved_equations, T_list, beg_range, cur_primary_constraint, cur_secondary_constraint, verbose, is_left_branch=left_is_left, has_bad_parent=!is_successful_run)
  _sweep_T_k(solved_equations, T_list, end_range, cur_primary_constraint, cur_secondary_constraint, verbose, is_left_branch=right_is_left, has_bad_parent=!is_successful_run)

  return is_successful_run

end

function _resweep_side_T_k_s(solved_equations, T_list, verbose)

  difference_dict = OrderedDict(
    "reverse" => Dict(
      "cur_indices" => length(T_list):-1:1,
      "cur_offset" => +1
    ),
    "forward" => Dict(
      "cur_indices" => 1:+1:length(T_list),
      "cur_offset" => -1
    )
  )

  for cur_entry in values(difference_dict)

    has_seen_number = false

    for cur_index in cur_entry["cur_indices"]
      if !has_seen_number && isnan(solved_equations["eta_CD"][cur_index])
        continue
      end

      if !isnan(solved_equations["eta_CD"][cur_index])
        has_seen_number = true
        continue
      end

      cur_neighbor = cur_index + cur_entry["cur_offset"]

      _sweep_T_k(solved_equations, T_list, cur_index, solved_equations["primary_constraint"][cur_neighbor], solved_equations["secondary_constraint"][cur_neighbor], verbose)

      if isnan(solved_equations["eta_CD"][cur_index])
        break
      end
    end

  end

end
