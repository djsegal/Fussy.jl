"""
    fill_out_cost_table!(MCT::CostTable, analyzed_solution::Dict)

Lorem ipsum dolor sit amet.
"""
function fill_out_cost_table!(MCT::CostTable, analyzed_solution::Dict)

  econ_table_yaml = "lib/input_decks/econ_cost_table.yml"

  incomplete_functions = [
    "Cost_HTS_Total",
    "Cost_ST_Total",
    "Cryoplant_Cost"
  ]

  for (cur_key, cur_val) in YAML.load_file(econ_table_yaml)

    if cur_val == nothing
      cur_val = Dict()
    end

    for (cur_sub_key, cur_sub_val) in cur_val
      eval_sub_val = cur_sub_val

      if eltype(eval_sub_val) == Char
        for cur_function in incomplete_functions
          replaced_string = "$cur_function($(analyzed_solution["R_0"]), "
          replaced_string *= "$(analyzed_solution["n_bar"]), "
          replaced_string *= "$(analyzed_solution["I_M"]))"

          eval_sub_val =
            replace(eval_sub_val, "$cur_function()", replaced_string)
        end

        eval_sub_val = eval( parse(eval_sub_val) )
      end

      if eltype(eval_sub_val) == SymPy.Sym
        eval_sub_val = subs(eval_sub_val,
          symbol_dict["T_k"] => analyzed_solution["T_k"],
          symbol_dict["R_0"] => analyzed_solution["R_0"],
          symbol_dict["B_0"] => analyzed_solution["B_0"],
          symbol_dict["I_M"] => analyzed_solution["I_M"],
          symbol_dict["n_bar"] => analyzed_solution["n_bar"]
        )
      end

      cur_val[cur_sub_key] = eval_sub_val

    end

    add_line_item!(MCT, cur_key, cur_val)

  end

end
