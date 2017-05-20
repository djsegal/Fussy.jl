"""
    add_line_item!(cur_table::CostTable, name::AbstractString)

Lorem ipsum dolor sit amet.
"""
function add_line_item!(cur_table::CostTable, name::AbstractString)
  new_line_item = LineItem(name)
  cur_table.line_items[name] = new_line_item

  new_line_item
end
