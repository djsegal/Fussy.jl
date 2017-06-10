"""
    CostTable(cur_R_0=R_0, cur_B_0=B_0, cur_T_k=T_k; analyzed_solution=Dict())

Lorem ipsum dolor sit amet.
"""
type CostTable

  R_0::Quantity
  B_0::Quantity
  T_k::Quantity

  analyzed_solution::Dict

  line_items::OrderedDict{AbstractString,LineItem}

  data_frame::DataFrame

  CostTable(cur_R_0=R_0, cur_B_0=B_0, cur_T_k=T_k; analyzed_solution=Dict()) = new(
    cur_R_0, cur_B_0, cur_T_k, analyzed_solution,
    OrderedDict{AbstractString,LineItem}(), DataFrame()
  )

end
