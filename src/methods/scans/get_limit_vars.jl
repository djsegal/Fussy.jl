function get_limit_vars(cur_scan::AbstractScan, cur_limit::Symbol, cur_field::Symbol; cur_first::Union{Void,Int}=nothing, cur_last::Union{Void,Int}=nothing)
  cur_field_symbol = Symbol("$(cur_limit)_reactors")

  cur_reactor_list = getfield(cur_scan, cur_field_symbol)

  cur_values = []

  for cur_reactor in cur_reactor_list
    cur_reactor.is_good || continue

    cur_value = nothing

    if isdefined(cur_reactor, cur_field)
      cur_value = getfield(cur_reactor, cur_field)
    elseif isdefined(Fussy, cur_field)
      cur_value = getfield(Fussy, cur_field)(cur_reactor)
    else
      getfield(cur_reactor, cur_field) # throw error
    end

    push!(cur_values, cur_value)
  end

  cur_length = length(cur_values)

  if cur_first != nothing && cur_first < cur_length
    return cur_values[1:cur_first]
  elseif cur_last != nothing && cur_last < cur_length
    return cur_values[end-(cur_last-1):end]
  end

  cur_values
end
