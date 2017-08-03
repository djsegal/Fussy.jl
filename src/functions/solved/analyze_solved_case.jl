"""
    analyze_solved_case(found_data; verbose=true)

Lorem ipsum dolor sit amet.
"""
function analyze_solved_case(found_data; verbose=true)

  solved_case = Dict()

  for (cur_key, cur_value) in found_data
    solved_case[cur_key] = cur_value
  end

  solved_case["n_bar"] = solved_steady_density() / 1u"n20"
  solved_case["I_M"] = solved_steady_current() / 1u"MA"
  solved_case["P_H"] = P_H() / 1u"MW"
  solved_case["P_alpha"] = P_alpha() / 1u"MW"
  solved_case["f_CD"] = f_CD()
  solved_case["f_B"] = f_B()
  solved_case["P_F"] = P_F() / 1u"MW"
  solved_case["P_BR"] = P_BR() / 1u"MW"
  solved_case["a"] = solved_case["R_0"] * epsilon

  given_equations = setup_given_equations()

  for (cur_key, cur_value) in given_equations
    tmp_value = cur_value["cur_limit"]

    tmp_value /= cur_value["max_limit"]

    if cur_key == "beta"
      solved_case["beta"] = tmp_value
    elseif cur_key == "wall"
      solved_case["P_W"] = tmp_value
    elseif cur_key == "heat"
      solved_case["h_parallel"] = tmp_value
    else
      error("Bad constraint key")
    end
  end

  cur_values = [ cur_value for cur_value in values(found_data) ]

  filter!(cur_value->!isa(cur_value,AbstractString), cur_values)

  if any(isnan, cur_values)
    for (cur_key, cur_value) in solved_case
      solved_case[cur_key] = NaN
    end

    return solved_case
  end

  for (cur_key, cur_value) in solved_case
    if eltype(cur_value) != SymPy.Sym
      continue
    end

    solved_case[cur_key] = calc_possible_values(
      cur_value,
      cur_T_k = ( solved_case["T_k"] * 1u"keV" ),
      cur_eta_CD = ( solved_case["eta_CD"] )
    )
  end

  for (cur_key, cur_value) in solved_case
    if eltype(cur_value) != SymPy.Sym
      continue
    end

    solved_case[cur_key] = subs(
      cur_value,
      symbol_dict["eta_CD"] => solved_case["eta_CD"],
      symbol_dict["n_bar"] => solved_case["n_bar"],
      symbol_dict["I_M"] => solved_case["I_M"],
      symbol_dict["R_0"] => solved_case["R_0"],
      symbol_dict["B_0"] => solved_case["B_0"],
      symbol_dict["T_k"] => solved_case["T_k"]
    )
  end

  for (cur_key, cur_value) in solved_case
    if eltype(cur_value) != SymPy.Sym
      continue
    end

    solved_case[cur_key] = SymPy.N(cur_value)
  end

  solved_case

end
