function safe_symbol(cur_reactor::AbstractReactor, cur_field::Symbol)
  cur_value = getfield(cur_reactor, cur_field)
  isa(cur_value, SymEngine.Basic) || return cur_value
  return symbols(cur_field)
end
