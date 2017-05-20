"""
    CostTable()

Lorem ipsum dolor sit amet.
"""
type CostTable

  line_items::OrderedDict{AbstractString,LineItem}

  data_frame::DataFrame

  CostTable() = new(OrderedDict{AbstractString,LineItem}(), DataFrame())

end
