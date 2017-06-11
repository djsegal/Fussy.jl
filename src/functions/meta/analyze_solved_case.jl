"""
    analyze_solved_case(found_data; verbose=true)

Lorem ipsum dolor sit amet.
"""
function analyze_solved_case(found_data; verbose=true)

  cur_R_0 = Tokamak.symbol_dict["R_0"]
  cur_B_0 = Tokamak.symbol_dict["B_0"]
  cur_n_bar = Tokamak.symbol_dict["n_bar"]
  cur_I_M = Tokamak.symbol_dict["I_M"]

  solved_case = Dict()

  solved_case["R_0"] = found_data["R_0"]
  solved_case["B_0"] = found_data["B_0"]
  solved_case["T_k"] = found_data["T_k"]

  solved_case["n_bar"] = Tokamak.calc_possible_values(subs(Tokamak.solved_steady_density() / 1u"n20", cur_R_0, solved_case["R_0"]))
  solved_case["I_M"] = Tokamak.calc_possible_values(Tokamak.solved_steady_current() / 1u"MA")

  solved_case["P_H"] = Tokamak.calc_possible_values(subs(subs(Tokamak.P_H() / 1u"MW", cur_n_bar, solved_case["n_bar"]), cur_R_0, solved_case["R_0"]))
  solved_case["P_alpha"] = Tokamak.calc_possible_values(subs(subs(Tokamak.P_alpha() / 1u"MW", cur_n_bar, solved_case["n_bar"]), cur_R_0, solved_case["R_0"]))
  solved_case["f_CD"] = Tokamak.calc_possible_values(subs(subs(subs(Tokamak.f_CD(), cur_n_bar, solved_case["n_bar"]), cur_R_0, solved_case["R_0"]), cur_I_M, solved_case["I_M"]))

  cur_f_B = Tokamak.f_B()
  cur_P_F = ( Tokamak.P_F() / 1u"MW" )
  cur_P_BR = ( Tokamak.P_BR() / 1u"MW" )

  has_actual_symbols =
    length( free_symbols( cur_P_F / Tokamak.symbol_dict["sigma_v_hat"] ) ) > 0

  if !has_actual_symbols
    cur_P_F = SymPy.N(Tokamak.calc_possible_values(cur_P_F))
  end

  if eltype(cur_f_B) == SymPy.Sym
    cur_f_B = SymPy.N(subs(subs(subs(cur_f_B, cur_n_bar, solved_case["n_bar"]), cur_R_0, solved_case["R_0"]), cur_I_M, solved_case["I_M"]))
  end

  if eltype(cur_P_F) == SymPy.Sym
    cur_P_F = SymPy.N(subs(Tokamak.calc_possible_values(subs(cur_P_F, cur_n_bar, solved_case["n_bar"])), cur_R_0, solved_case["R_0"]))
  end

  if eltype(cur_P_BR) == SymPy.Sym
    cur_P_BR = Tokamak.calc_possible_values(subs(subs(cur_P_BR, cur_n_bar, solved_case["n_bar"]), cur_R_0, solved_case["R_0"]))
  end

  solved_case["f_B"] = cur_f_B
  solved_case["P_F"] = cur_P_F
  solved_case["P_BR"] = cur_P_BR

  solved_case["a"] = solved_case["R_0"] * Tokamak.epsilon

  given_equations = Tokamak.setup_given_equations()

  for (key, value) in given_equations
    tmp_value = value["cur_limit"]

    tmp_value = subs(tmp_value, cur_n_bar, solved_case["n_bar"])
    tmp_value = subs(tmp_value, cur_I_M, solved_case["I_M"])

    tmp_value = Tokamak.calc_possible_values(tmp_value)

    if tmp_value == SymPy.Sym
      tmp_value = subs(tmp_value, cur_R_0, solved_case["R_0"])
      tmp_value = subs(tmp_value, cur_B_0, solved_case["B_0"])
      tmp_value = SymPy.N(tmp_value)
    end

    if verbose
      println("$key = $( @sprintf("%.3g", tmp_value / value["max_limit"] ) )")
    end

    if key == "beta"
      solved_case["beta"] = tmp_value
    elseif key == "wall"
      solved_case["P_W"] = tmp_value
    elseif key == "heat"
      solved_case["h_parallel"] = tmp_value
    else
      error("Bad constraint key")
    end
  end

  solved_case

end
