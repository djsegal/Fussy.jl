function minimize(cur_reactor, cur_field, init_reactor=nothing)
  cur_count = 0

  if is_present(init_reactor) && cur_reactor.constraint != init_reactor.constraint
    tmp_value = getfield(init_reactor, cur_field)

    tmp_reactor = deepcopy(cur_reactor)

    if tmp_reactor.is_consistent
      tmp_reactor = hone(tmp_reactor, cur_field, tmp_value)
    else
      tmp_reactors = match(tmp_reactor, cur_field, tmp_value, false)
      tmp_reactor = isempty(tmp_reactors) ? nothing : first(tmp_reactors)
    end

    cur_count += 1

    is_nothing(tmp_reactor) && return
    tmp_reactor.is_valid || return
    tmp_reactor.is_good || return
  end

  cur_T_bar_list = bisect_reorder!(
    collect(linspace(min_T_bar, max_T_bar, 31))
  )

  for cur_T_bar in cur_T_bar_list
    is_present(init_reactor) && break

    tmp_reactor = deepcopy(cur_reactor)
    tmp_reactor.T_bar = cur_T_bar

    solve!(tmp_reactor)
    cur_count += 1

    tmp_reactor.is_valid || continue
    tmp_reactor.is_good || continue

    init_reactor = tmp_reactor
  end

  is_nothing(init_reactor) && return

  min_reactors = [init_reactor]

  good_value = getfield(init_reactor, cur_field)
  bad_value = NaN

  while isnan(bad_value)
    tmp_value = good_value / 2

    tmp_reactor = deepcopy(cur_reactor)

    if tmp_reactor.is_consistent
      tmp_reactor = hone(tmp_reactor, cur_field, tmp_value)
      tmp_reactors = [tmp_reactor]
    else
      tmp_reactors = match(tmp_reactor, cur_field, tmp_value, false)
      tmp_reactor = isempty(tmp_reactors) ? nothing : first(tmp_reactors)
    end

    cur_count += 1

    if !is_nothing(tmp_reactor) && tmp_reactor.is_valid && tmp_reactor.is_good
      min_reactors = tmp_reactors
      good_value = tmp_value
    else
      bad_value = tmp_value
    end
  end

  while ( abs( good_value - bad_value ) / good_value ) > 1e-8
    tmp_value = middle(good_value, bad_value)

    tmp_reactor = deepcopy(cur_reactor)

    if tmp_reactor.is_consistent
      tmp_reactor = hone(tmp_reactor, cur_field, tmp_value)
      tmp_reactors = [tmp_reactor]
    else
      tmp_reactors = match(tmp_reactor, cur_field, tmp_value, false)
      tmp_reactor = isempty(tmp_reactors) ? nothing : first(tmp_reactors)
    end

    cur_count += 1

    if !is_nothing(tmp_reactor) && tmp_reactor.is_valid && tmp_reactor.is_good
      min_reactors = tmp_reactors
      good_value = tmp_value
    else
      bad_value = tmp_value
    end
  end

  ( length(min_reactors) > 1 ) && custom_log("Minimize Bug...")
  ( length(min_reactors) > 1 ) && custom_log(min_reactors)

  min_reactors[1]
end
