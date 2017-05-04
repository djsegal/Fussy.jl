"""
    sweep_T_k()

Lorem ipsum dolor sit amet.
"""
function sweep_T_k(T_list)

  cur_R_0 = symbol_dict["R_0"]
  cur_B_0 = symbol_dict["B_0"]

  cur_n_bar = symbol_dict["n_bar"]
  cur_I_M = symbol_dict["I_M"]

  given_equations = OrderedDict()

  given_equations["beta"] = OrderedDict(
    "R_0" => solved_R_0_from_beta,
    "B_0" => solved_B_0_from_beta,
    "cur_limit" => ( troyon_beta_limit() + beta_N ),
    "max_limit" => max_beta_N
  )

  given_equations["wall"] = OrderedDict(
    "R_0" => solved_R_0_from_wall,
    "B_0" => solved_B_0_from_wall,
    "cur_limit" => ( wall_loading_limit() + P_W ) / ( 1u"MW" / 1u"m^2" ),
    "max_limit" => max_P_W / ( 1u"MW" / 1u"m^2" )
  )

  given_equations["heat"] = OrderedDict(
    "R_0" => solved_R_0_from_heat,
    "B_0" => solved_B_0_from_heat,
    "cur_limit" => ( heat_load_limit() + h_parallel ) / ( 1u"MW" / 1u"m^2" ),
    "max_limit" => max_h_parallel / ( 1u"MW" / 1u"m^2" )
  )

  load_input( "beta_N = $(max_beta_N)" )
  load_input( "P_W = $( max_P_W / ( 1u"MW" / 1u"m^2" ) ) * ( 1u\"MW\" / 1u\"m^2\" )" )
  load_input( "h_parallel = $( max_h_parallel / ( 1u"MW" / 1u"m^2" ) ) * ( 1u\"MW\" / 1u\"m^2\" )" )

  solved_equations = OrderedDict()

  for key in keys(given_equations)
    solved_equations[key] = OrderedDict()

    solved_equations[key]["R_0"] = []
    solved_equations[key]["B_0"] = []

    solved_equations[key]["other_limits"] = OrderedDict()

    for sub_key in keys(given_equations)
      solved_equations[key]["other_limits"][sub_key] = []
    end
  end

  for cur_T in T_list
    load_input( "T_k = $(cur_T)u\"keV\"" )

    cur_simplified_density = simplified_density() / 1u"n20"
    cur_simplified_current = simplified_current() / 1u"MA"

    for (key, value) in given_equations
      cur_solved_R_0 = given_equations[key]["R_0"]() / 1u"m"
      cur_solved_B_0 = given_equations[key]["B_0"]() / 1u"T"

      push!(solved_equations[key]["R_0"], cur_solved_R_0)
      push!(solved_equations[key]["B_0"], cur_solved_B_0)

      for (sub_key, sub_value) in given_equations
        tmp_value = sub_value["cur_limit"]

        tmp_value = subs(tmp_value, cur_n_bar, cur_simplified_density)
        tmp_value = subs(tmp_value, cur_I_M, cur_simplified_current)

        tmp_value = calc_possible_values(tmp_value)

        tmp_value = subs(tmp_value, cur_R_0, cur_solved_R_0)
        tmp_value = subs(tmp_value, cur_B_0, cur_solved_B_0)

        tmp_value /= sub_value["max_limit"]

        push!(solved_equations[key]["other_limits"][sub_key], tmp_value)
      end
    end
  end

  for (key, value) in solved_equations
    println("\n$(key)\n")

    println("R_0 = ")
    println(solved_equations[key]["R_0"])

    println("B_0 = ")
    println(solved_equations[key]["B_0"])

    println("other_limits = ")
    for sub_key in keys(solved_equations)
      println("$sub_key: $(solved_equations[key]["other_limits"][sub_key])")
    end
  end

  return solved_equations

end
