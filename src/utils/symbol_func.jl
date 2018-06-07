macro symbol_func(cur_expr::Expr)
  @assert cur_expr.head == :function

  cur_call = cur_expr.args[1]

  cur_func_name = cur_call.args[1]

  cur_main_var = cur_call.args[2].args[1]

  cur_param = Expr(
    :kw,
    Expr(
      :(::),
      :is_direct_call,
      :Bool
    ),
    false
  )

  push!(cur_call.args, cur_param)

  cur_sub_expr = parse("""
    $(cur_main_var).is_symbolic && !is_direct_call &&
      return symbols("$(cur_func_name)")
  """)

  unshift!(cur_expr.args[2].args, cur_sub_expr)

  cur_expr
end
