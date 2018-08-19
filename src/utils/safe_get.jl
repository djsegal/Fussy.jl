function safe_get(cur_dict::Dict, cur_field, cur_default)
  cur_symbol = Symbol(cur_field)
  haskey(cur_dict, cur_symbol) || return cur_default
  cur_dict[cur_symbol]
end

function safe_get(cur_array::AbstractArray, cur_field, cur_default)
  safe_get(Dict(cur_array), cur_field, cur_default)
end

function safe_get(cur_reactor::AbstractReactor, cur_field)
  cur_symbol = Symbol(cur_field)

  isdefined(cur_reactor, cur_symbol) && return getfield(cur_reactor, cur_symbol)

  cur_func = getfield(Fussy, cur_symbol)
  cur_value = cur_func(cur_reactor)

  if isa(cur_value, SymEngine.Basic)
    cur_value = subs(cur_value, symbols(:sigma_v) => calc_sigma_v(cur_reactor))
    cur_value = cur_value |> N
  end

  cur_value
end
