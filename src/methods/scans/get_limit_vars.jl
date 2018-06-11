function get_limit_vars(cur_scan::AbstractScan, cur_limit::Symbol, cur_field::Symbol; cur_first::Union{Void,Int}=nothing, cur_last::Union{Void,Int}=nothing)
  cur_field_symbol = Symbol("$(cur_limit)_reactors")

  cur_reactor_list = getfield(cur_scan, cur_field_symbol)

  cur_values = []

  for cur_reactor in cur_reactor_list
    cur_reactor.is_good || continue

    push!(
      cur_values,
      getfield(cur_reactor, cur_field)
    )
  end

  cur_length = length(cur_values)

  if cur_first != nothing && cur_first < cur_length
    return cur_values[1:cur_first]
  elseif cur_last != nothing && cur_last < cur_length
    return cur_values[end-(cur_last-1):end]
  end

  cur_values
end
