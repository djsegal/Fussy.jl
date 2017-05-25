"""
    add_line_item!(cur_table::CostTable, name::AbstractString, cur_fields::Dict=Dict())

Lorem ipsum dolor sit amet.
"""
function add_line_item!(cur_table::CostTable, name::AbstractString, cur_fields::Dict=Dict())
  new_line_item = LineItem(name)

  for (cur_key, cur_val) in cur_fields
    if eltype(cur_val) == Char
      cur_val = eval( parse(cur_val) )
    end

    setfield!(new_line_item, Symbol(cur_key), float(cur_val))
  end

  cur_table.line_items[name] = new_line_item

  new_line_item
end
