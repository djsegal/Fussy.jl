"""
    update_cost_data_frame!(cur_table::CostTable)

Lorem ipsum dolor sit amet.
"""
function update_cost_data_frame!(cur_table::CostTable)
  cur_data_frame = DataFrame()

  cur_data_frame[:Item] = map( cur_item -> cur_item.name, values(cur_table.line_items) )
  cur_data_frame[:DollarsPer] = map( cur_item -> cur_item.price_per, values(cur_table.line_items) )
  cur_data_frame[:Quantity] = map( cur_item -> cur_item.quantity, values(cur_table.line_items) )
  cur_data_frame[:FabFactor] = map( cur_item -> cur_item.fab_factor, values(cur_table.line_items) )

  cur_data_frame[:TotalCost] =
    map( cur_item -> calculate_total_cost(cur_item), values(cur_table.line_items) )

  cur_table.data_frame = cur_data_frame

  cur_data_frame
end
