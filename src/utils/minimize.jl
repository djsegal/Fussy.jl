function minimize(f, a, b; fa=nothing, fb=nothing, no_pts=41, atol=10*eps(), rtol=10*eps(), verbose=false, robust=true, min_pts=5)
  @assert no_pts >= min_pts

  cur_counter_function = isa(f, CounterFunction) ? f : CounterFunction(f)

  a, b, fa, fb = find_valid_range(
    cur_counter_function, a, b; fa=fa, fb=fb, no_pts=no_pts,
    atol=atol, rtol=rtol, robust=robust, return_indices=[1,2,3,4]
  )

  isnan(a) && return (NaN, NaN)
  isnan(b) && return (NaN, NaN)

  cur_x_list = collect(linspace(a,b,no_pts))
  cur_f_list = fill!(Vector{Float64}(no_pts), Inf)

  cur_f_list[1] = fa
  cur_f_list[end] = fb

  cur_is_active = [true, true]
  for (cur_loop_index, cur_point_index) in enumerate(centering_indices(no_pts)[3:end])
    cur_is_active[(cur_loop_index-1)%2+1] || continue

    work_x = cur_x_list[cur_point_index]
    work_f = cur_counter_function(work_x)

    isfinite(work_f) || continue
    cur_f_list[cur_point_index] = work_f

    if isodd(cur_loop_index)
      prev_f = last(filter(isfinite, cur_f_list[1:cur_point_index-1]))
    else
      prev_f = first(filter(isfinite, cur_f_list[cur_point_index+1:end]))
    end
    ( work_f > prev_f ) || continue

    cur_is_active[(cur_loop_index-1)%2+1] = false
    ( prev_f == minimum(cur_f_list) ) && break
  end

  (found_min_f, found_index) = findmin(cur_f_list)

  found_min_x = cur_x_list[found_index]

  ( found_index == 1 ) && return (found_min_x, found_min_f)
  ( found_index == no_pts ) && return (found_min_x, found_min_f)

  loose_isapprox(found_min_x, a, atol, rtol) && return (found_min_x, found_min_f)
  loose_isapprox(found_min_x, b, atol, rtol) && return (found_min_x, found_min_f)

  ( fa != nothing && loose_isapprox(found_min_f, fa, atol, rtol) ) && return (found_min_x, found_min_f)
  ( fb != nothing && loose_isapprox(found_min_f, fb, atol, rtol) ) && return (found_min_x, found_min_f)

  tmp_indices = zeros(Int, 3)
  tmp_indices[1] = findlast(isfinite, cur_f_list[1:found_index-1])
  tmp_indices[2] = found_index
  tmp_indices[3] = found_index + findfirst(isfinite, cur_f_list[found_index+1:end])

  if any(iszero, tmp_indices)
    fit_min_x = NaN
    fit_min_f = Inf
  else
    tmp_x_list = cur_x_list[tmp_indices]
    tmp_f_list = cur_f_list[tmp_indices]

    fit_min_x = first(roots(polyder(
      polyfit(tmp_x_list, tmp_f_list, 2)
    )))

    if is_inside(fit_min_x, a, b)
      fit_min_f = cur_counter_function(fit_min_x)
    else
      fit_min_x = NaN
      fit_min_f = Inf
    end
  end

  if found_min_f <= fit_min_f
    a, b = cur_x_list[found_index-1], cur_x_list[found_index+1]
    fa, fb = cur_f_list[found_index-1], cur_f_list[found_index+1]
  else
    a, fa = found_min_x, found_min_f
    b = fit_min_x + ( fit_min_x - found_min_x )
    fb = f(b)
  end

  no_pts = max(min_pts, Int(floor(no_pts/2)))

  cur_min_x, cur_min_f = minimize(
    cur_counter_function, a, b; fa=fa, fb=fb, no_pts=no_pts, atol=atol, rtol=rtol, robust=robust
  )

  verbose && custom_log("Number of Calls: $(cur_counter_function.count)")

  return (cur_min_x, cur_min_f)
end

function find_valid_range(f, a, b; fa=nothing, fb=nothing, no_pts=41, atol=10*eps(), rtol=10*eps(), verbose=false, robust=true, return_indices=[1,2])
  cur_counter_function = isa(f, CounterFunction) ? f : CounterFunction(f)

  @sync begin
    @async ( fa == nothing ) && ( fa = cur_counter_function(a) )
    @async ( fb == nothing ) && ( fb = cur_counter_function(b) )
  end

  cur_output = _find_valid_range(cur_counter_function, a, b, fa, fb, atol, rtol, return_indices)

  if robust && all(isnan, cur_output)
    c = NaN
    fc = NaN
    for tmp_c in bisect_reorder!(collect(linspace(a,b,no_pts))[2:end-1])
      tmp_fc = cur_counter_function(tmp_c)
      isfinite(tmp_fc) || continue

      c = tmp_c
      fc = tmp_fc
      break
    end

    if isfinite(c) && isfinite(fc)
      tmp_top_output = nothing
      tmp_bot_output = nothing

      @sync begin
        @async tmp_top_output = _find_valid_range(cur_counter_function, a, c, NaN, fc, atol, rtol, return_indices)[map(isodd,1:length(return_indices))]
        @async tmp_bot_output = _find_valid_range(cur_counter_function, c, b, fc, NaN, atol, rtol, return_indices)[map(iseven,1:length(return_indices))]
      end

      cur_output = collect(Iterators.flatten(zip(tmp_top_output,tmp_bot_output)))
    end
  end

  verbose && custom_log("Number of Calls: $(cur_counter_function.count)")
  cur_output
end

function _find_valid_range(f::AbstractCounterFunction, a, b, fa, fb, atol, rtol, return_indices)
  ( isfinite(fa) || isfinite(fb) ) || return [NaN, NaN, NaN, NaN][return_indices]
  ( isfinite(fa) && isfinite(fb) ) && return [a, b, fa, fb][return_indices]

  if loose_isapprox(a, b, atol, rtol)
    isfinite(fa) && return [a, a, fa, fa][return_indices]
    return [b, b, fb, fb][return_indices]
  end

  a_is_good = isfinite(fa)

  if a_is_good
    good_x = a

    bad_x = b
    bad_f = fb
  else
    good_x = b

    bad_x = a
    bad_f = fa
  end

  prev_x, prev_f = NaN, NaN
  while !isfinite(bad_f) && !loose_isapprox(bad_x, good_x, atol, rtol)
    prev_x, bad_x = bad_x, middle(bad_x, good_x)
    prev_f, bad_f = bad_f, f(bad_x)
  end

  if loose_isapprox(bad_x, good_x, atol, rtol)
    isfinite(fa) && return [a, a, fa, fa][return_indices]
    return [b, b, fb, fb][return_indices]
  end

  @assert isfinite(bad_f)

  good_x, bad_x = bad_x, prev_x
  good_f, bad_f = bad_f, prev_f

  tmp_x, good_x = _find_valid_range(
    f, good_x, bad_x, good_f, bad_f, atol, rtol, return_indices
  )

  if a_is_good
      return [a, good_x, fa, good_f][return_indices]
  else
      return [good_x, b, good_f, fb][return_indices]
  end
end
