"""
    scan_for_R_0(R_0_value, B_list=linspace(3,12,4); rel_tol=1e-3, is_first_call=true, verbose=false)

Lorem ipsum dolor sit amet.
"""
function scan_for_R_0(R_0_value, B_list=linspace(3,12,4); rel_tol=1e-3, is_first_call=true, verbose=false)

  B_count = length(B_list)

  if is_first_call
    cur_data = sweep_B_0(B_list, verbose=verbose)
  else
    sub_section = 2 : ( B_count - 1 )
    cur_data = sweep_B_0(B_list[sub_section], verbose=verbose)
  end

  bad_indices = findin(cur_data["T_k"], NaN)

  current_R_0_s = cur_data["R_0"]
  current_T_k_s = cur_data["T_k"]
  current_eta_CD_s = cur_data["eta_CD"]

  R_0_diff = diff(current_R_0_s)
  R_0_diff = R_0_diff[.!isnan.(R_0_diff)]

  is_monotonic = all( x -> x >= 0 , R_0_diff )
  is_monotonic |= all( x -> x <= 0 , R_0_diff )

  if !is_monotonic
    error("Non-monotonic R_0 values")
  end

  if is_first_call
    for cur_key in keys(cur_data)
      cur_obj = cur_data[cur_key]

      if isa(cur_obj, Array)
        deleteat!(cur_obj, bad_indices)
        continue
      end

      for cur_sub_key in keys(cur_obj)
        deleteat!(cur_obj[cur_sub_key], bad_indices)
      end
    end

    B_list = cur_data["B_0"]
    B_count = length(B_list)
  end

  if enable_eta_CD_derive
    load_input(" default_eta_CD = $(mean(current_eta_CD_s)) ")
  end

  first_R_0 = current_R_0_s[1]
  last_R_0 = current_R_0_s[length(current_R_0_s)]

  if first_R_0 > last_R_0
    first_R_0, last_R_0 = last_R_0, first_R_0

    reverse!(current_R_0_s)
    reverse!(current_T_k_s)
    reverse!(current_eta_CD_s)

    reverse!(B_list)
  end

  if is_first_call

    spans_R_0 = first_R_0 <= R_0_value && last_R_0 >= R_0_value

    if !spans_R_0
      println(B_list)
      println(R_0_value)
      println(current_R_0_s)
      error("B_0 range does not include R_0")
    end

  end

  error_list = ( current_R_0_s - R_0_value )
  found_values = find(x -> 0 < x < rel_tol, error_list)

  if !isempty(found_values)
    found_index = found_values[1]

    found_data = Dict(
      "B_0" => B_list[found_index],
      "R_0" => current_R_0_s[found_index],
      "T_k" => current_T_k_s[found_index],
      "eta_CD" => current_eta_CD_s[found_index]
    )

    return found_data
  end

  low_index = findlast(map(x -> x <= R_0_value, current_R_0_s))
  high_index = findfirst(map(x -> x >= R_0_value, current_R_0_s))

  if !is_first_call

    low_index += 1
    high_index += 1

    if high_index == 1
      high_index = B_count
    end

  end

  new_B_list = linspace(B_list[low_index], B_list[high_index], 3)

  return scan_for_R_0(R_0_value, new_B_list, rel_tol=rel_tol, is_first_call=false, verbose=verbose)
end
