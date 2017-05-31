"""
    calculate_total_cost(cur_item::LineItem)

Lorem ipsum dolor sit amet.
"""
function calculate_total_cost(cur_item::LineItem)

  cur_total_cost = cur_item.quantity

  cur_total_cost *= cur_item.price_per
  cur_total_cost *= cur_item.fab_factor

  cur_total_cost

end
