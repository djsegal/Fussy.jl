"""
    score_case(analyzed_case, cur_reactor, exclude_list=[])

Lorem ipsum dolor sit amet.
"""
function score_case(analyzed_case, cur_reactor, exclude_list=[])
  cur_score = OrderedDict(
    "grade_A" => 0,
    "grade_B" => 0,
    "grade_C" => 0,
    "grade_D" => 0,
    "grade_F" => 0
  )

  for cur_key in keys(Fusion.reactor_tables[cur_reactor])
    in(cur_key, exclude_list) && continue

    expected_value = Fusion.reactor_tables[cur_reactor][cur_key]
    actual_value = analyzed_case[cur_key]

    ( cur_key == "f_CD") && continue
    ( expected_value == "-") && continue
    iszero( expected_value - actual_value ) && continue

    if isnan(actual_value)
        cur_score["grade_F"] += 1
        continue
    end

    if in(cur_key, values(Fusion.constraint_params))
        (
            cur_key == Fusion.constraint_params[analyzed_case["primary_constraint"]] ||
            cur_key == Fusion.constraint_params[analyzed_case["secondary_constraint"]]
        ) && continue

        actual_value *= getfield( Fusion, Symbol("max_$(cur_key)") )
    end

    cur_rel_error = abs(expected_value - actual_value)
    cur_rel_error /= min(expected_value, actual_value)

    if cur_rel_error < 0.05
        cur_score["grade_A"] += 1
    elseif cur_rel_error < 0.1
        cur_score["grade_B"] += 1
    elseif cur_rel_error < 0.25
        cur_score["grade_C"] += 1
    elseif cur_rel_error < 0.5
        cur_score["grade_D"] += 1
    else
        cur_score["grade_F"] += 1
    end
  end

  cur_score
end
