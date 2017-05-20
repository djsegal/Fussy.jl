"""
    overnight_cost(cur_table::CostTable)

Lorem ipsum dolor sit amet.
"""
function overnight_cost(cur_table::CostTable)
  sum( cur_table.data_frame[:TotalCost] )
end
