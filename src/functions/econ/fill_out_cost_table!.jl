"""
    fill_out_cost_table!(MCT::CostTable)

Lorem ipsum dolor sit amet.
"""
function fill_out_cost_table!(MCT::CostTable)

  econ_table_yaml = "lib/input_decks/econ_cost_table.yml"

  for (cur_key, cur_val) in YAML.load_file(econ_table_yaml)

    if cur_val == nothing
      cur_val = Dict()
    end

    add_line_item!(MCT, cur_key, cur_val)

  end

end
