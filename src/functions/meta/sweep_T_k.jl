"""
    sweep_T_k()

Lorem ipsum dolor sit amet.
"""
function sweep_T_k(T_list)

  cur_R_0 = symbol_dict["R_0"]
  cur_B_0 = symbol_dict["B_0"]

  cur_n_bar = symbol_dict["n_bar"]
  cur_I_M = symbol_dict["I_M"]

  given_equations = setup_given_equations()

  load_input( "beta_N = $(max_beta_N)" )
  load_input( "P_W = $( max_P_W / ( 1u"MW" / 1u"m^2" ) ) * ( 1u\"MW\" / 1u\"m^2\" )" )
  load_input( "h_parallel = $( max_h_parallel / ( 1u"MW" / 1u"m^2" ) ) * ( 1u\"MW\" / 1u\"m^2\" )" )

  solved_equations = OrderedDict()

  for key in keys(given_equations)
    solved_equations[key] = OrderedDict()

    solved_equations[key]["R_0"] = SharedArray(Float64, length(T_list))
    solved_equations[key]["B_0"] = SharedArray(Float64, length(T_list))

    solved_equations[key]["other_limits"] = OrderedDict()

    for sub_key in keys(given_equations)
      solved_equations[key]["other_limits"][sub_key] = SharedArray(Float64, length(T_list))
    end
  end

  cur_solved_steady_density = solved_steady_density() / 1u"n20"
  cur_solved_steady_current = solved_steady_current() / 1u"MA"

  @inbounds @sync @parallel for cur_index in 1:length(T_list)
    cur_T = T_list[cur_index]

    load_input( "T_k = $(cur_T)u\"keV\"" )

    for (key, value) in given_equations
      cur_solved_R_0 = given_equations[key]["R_0"]() / 1u"m"
      cur_solved_B_0 = given_equations[key]["B_0"]() / 1u"T"

      solved_equations[key]["R_0"][cur_index] = cur_solved_R_0
      solved_equations[key]["B_0"][cur_index] = cur_solved_B_0

      for (sub_key, sub_value) in given_equations
        tmp_value = sub_value["cur_limit"]

        tmp_value = subs(tmp_value,
          cur_n_bar => cur_solved_steady_density,
          cur_I_M => cur_solved_steady_current
        )

        tmp_value = calc_possible_values(tmp_value)

        tmp_value = subs(tmp_value,
          cur_R_0 => cur_solved_R_0,
          cur_B_0 => cur_solved_B_0
        )

        tmp_value /= sub_value["max_limit"]

        solved_equations[key]["other_limits"][sub_key][cur_index] = tmp_value
      end
    end
  end

  return solved_equations

end
