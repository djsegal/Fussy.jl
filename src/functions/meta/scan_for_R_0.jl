"""
    scan_for_R_0()

Lorem ipsum dolor sit amet.
"""
function scan_for_R_0(R_0_value, T_list=linspace(5,30,5); rel_tol=1e-3, is_first_call=true)

  T_count = length(T_list)

  if is_first_call
    cur_data = sweep_T_k(T_list)["beta"]
  else
    sub_section = 2 : ( T_count - 1 )
    cur_data = sweep_T_k(T_list[sub_section])["beta"]
  end

  current_R_0_s = cur_data["R_0"]
  current_B_0_s = cur_data["B_0"]

  R_0_diff = diff(current_R_0_s)
  R_0_diff = R_0_diff[!isnan(R_0_diff)]

  is_monotonic = all( x -> x >= 0 , R_0_diff )
  is_monotonic |= all( x -> x <= 0 , R_0_diff )

  if !is_monotonic
    error("Non-monotonic R_0 values")
  end

  first_R_0 = current_R_0_s[1]
  last_R_0 = current_R_0_s[length(current_R_0_s)]

  if first_R_0 > last_R_0
    first_R_0, last_R_0 = last_R_0, first_R_0

    reverse!(current_R_0_s)
    reverse!(current_B_0_s)

    reverse!(T_list)
  end

  if is_first_call

    spans_R_0 = first_R_0 <= R_0_value && last_R_0 >= R_0_value

    if !spans_R_0
      error("T_k range does not include R_0")
    end

  end

  error_list = ( current_R_0_s - R_0_value )
  found_values = find(x -> 0 < x < rel_tol, error_list)

  if !isempty(found_values)
    found_index = found_values[1]

    found_data = Dict(
      "T_k" => T_list[found_index],
      "R_0" => current_R_0_s[found_index],
      "B_0" => current_B_0_s[found_index]
    )

    return found_data
  end

  low_index = findlast(map(x -> x <= R_0_value, current_R_0_s))
  high_index = findfirst(map(x -> x >= R_0_value, current_R_0_s))

  if !is_first_call

    low_index += 1
    high_index += 1

    if high_index == 1
      high_index = T_count
    end

  end

  new_T_list = linspace(T_list[low_index], T_list[high_index], 3)

  return scan_for_R_0(R_0_value, new_T_list, rel_tol=rel_tol, is_first_call=false)
end
