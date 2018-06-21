mutable struct Scan <: AbstractScan
  T_bar_list::Vector{AbstractFloat}

  deck::Union{Void, Symbol}

  beta_reactors::Vector{AbstractReactor}
  kink_reactors::Vector{AbstractReactor}
  pcap_reactors::Vector{AbstractReactor}
  wall_reactors::Vector{AbstractReactor}
  heat_reactors::Vector{AbstractReactor}
end

function Scan(cur_T_bar_list::Any, cur_limit::Symbol; cur_kwargs...)
  cur_dict = merge!(Dict(), Dict(cur_kwargs))

  Scan(cur_T_bar_list, [cur_limit], cur_dict)
end

function Scan(cur_T_bar_list::Any, cur_limits::AbstractArray=collect(keys(secondary_limits)); cur_kwargs...)
  cur_dict = merge!(Dict(), Dict(cur_kwargs))

  Scan(cur_T_bar_list, cur_limits, cur_dict)
end

function Scan(cur_T_bar_list::Any, cur_limits::AbstractArray, cur_dict::Dict)
  cur_deck = haskey(cur_dict, :deck) ?
    cur_dict[:deck] : nothing

  roots_count = max_roots
  limit_count = length(cur_limits)
  T_bar_count = length(cur_T_bar_list)

  reactor_count = T_bar_count * limit_count

  cur_scan = Scan(
    cur_T_bar_list, cur_deck,
    [ AbstractReactor[] for cur_index in 1:length(keys(secondary_limits)) ]...
  )

  cur_array = SharedArray{Float64}(limit_count, T_bar_count, roots_count)
  fill!(cur_array, NaN)

  cur_func = function (cur_index::Integer)
    cur_row = fld(cur_index-1, T_bar_count) + 1
    cur_col = mod(cur_index-1, T_bar_count) + 1

    cur_limit = cur_limits[cur_row]
    cur_T_bar = cur_scan.T_bar_list[cur_col]

    cur_reactor = Reactor(
      cur_T_bar, merge(cur_dict, Dict(Symbol("constraint") => cur_limit))
    )

    cur_I_P_list = solve(cur_reactor)
    cur_array[cur_row, cur_col, 1:length(cur_I_P_list)] = cur_I_P_list
  end

  cur_progress = Progress(reactor_count)
  pmap(cur_func, cur_progress, 1:reactor_count)

  for cur_row in 1:limit_count
    cur_limit = cur_limits[cur_row]
    cur_field_symbol = Symbol("$(cur_limit)_reactors")

    cur_reactor_list = getfield(cur_scan, cur_field_symbol)

    for (cur_col, cur_T_bar) in enumerate(cur_scan.T_bar_list)
      for cur_root in cur_array[cur_row, cur_col, :]
        isnan(cur_root) && break

        cur_reactor = Reactor(
          cur_T_bar, merge(cur_dict, Dict(Symbol("constraint") => cur_limit))
        )

        cur_reactor.I_P = cur_root

        push!(cur_reactor_list, update!(cur_reactor))
      end
    end
  end

  cur_scan
end
