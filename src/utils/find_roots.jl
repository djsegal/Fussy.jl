function find_roots(f, a::Real, b::Real, args...;
                    no_pts::Int=101,
                    abstol::Real=10*eps(), reltol::Real=10*eps(), ## should be abstol, reltol as used.
                    kwargs...)

    @assert a != b
    @assert no_pts > 1

    ( a < b ) || ( (a, b) = (b, a) )

    work_f(x) = real(float(f(complex(x))))

    root_list = _find_recursive_roots(
      work_f, a, b, args...;
      no_pts=no_pts, abstol=abstol, reltol=reltol, kwargs...
    )

    # redo if it appears function oscillates alot in this interval...
    if length(root_list) > Int(ceil( (1/4) * no_pts ))
        return find_roots(
            f, a, b, args...;
            no_pts = 10*no_pts, abstol=abstol, reltol=reltol, kwargs...
        )
    end

    sort!(root_list)

    root_list
end

function _find_recursive_roots(f, a::Real, b::Real, args...;
                      cur_depth::Int=1,
                      no_pts::Int=101,
                      abstol::Real=10*eps(), reltol::Real=10*eps(), ## should be abstol, reltol as used.
                      kwargs...)

    cur_range = collect(linspace(a, b, no_pts))

    root_list = find_root_list(f, cur_range, abstol, reltol)

    isempty(root_list) && return root_list

    sub_no_pts = no_pts
    sub_no_pts /= 1 + length(root_list) / 3
    sub_no_pts /= 2 ^ ( cur_depth - 1 )
    sub_no_pts = Int(round(sub_no_pts))

    ( sub_no_pts > 1 ) || return root_list

    cur_intervals = zip(
        vcat(first(cur_range),root_list),
        vcat(root_list,last(cur_range))
    )

    for (cur_a, cur_b) in cur_intervals
        loose_isapprox(cur_a, cur_b, abstol, reltol) && continue

        tmp_a = find_next_non_root(cur_a, f, cur_b, reltol, abstol)
        tmp_b = find_next_non_root(cur_b, f, cur_a, reltol, abstol)

        isnan(tmp_a) || isnan(tmp_b) && continue
        loose_isapprox(tmp_a, tmp_b, abstol, reltol) && continue
        ( tmp_a < tmp_b ) || continue

        cur_roots = _find_recursive_roots(
            f, tmp_a, tmp_b, args...;
            no_pts=sub_no_pts, abstol=abstol, reltol=reltol,
            cur_depth=(cur_depth+1), kwargs...
        )

        append!(root_list, cur_roots)
    end

    root_list
end

function find_next_non_root(cur_root, cur_func, barrier_point, reltol, abstol)
    cur_direction = sign(barrier_point - cur_root)

    cur_adder = abstol * cur_direction
    cur_value = cur_root + cur_adder

    while sign(barrier_point - cur_value) == cur_direction
        if !loose_isapprox(cur_value, cur_root, abstol, reltol)
          cur_f = cur_func(cur_value)
          isapprox(cur_f, 0.0, atol=abstol) || break
        end

        cur_adder *= 2
        cur_value += cur_adder
    end

    is_in_range = ( sign(barrier_point - cur_value) == cur_direction )
    is_in_range || return NaN

    for tmp_value in linspace(cur_value - cur_adder, cur_value)
        ( sign(tmp_value - cur_root) == cur_direction ) || continue

        loose_isapprox(tmp_value, cur_root, abstol, reltol) && continue

        cur_f = cur_func(tmp_value)

        isapprox(cur_f, 0.0, atol=abstol) && continue

        cur_value = tmp_value
        break
    end

    ( cur_root == cur_value ) && return NaN

    cur_value
end

function find_root_list(f, cur_range::AbstractVector{T}, abstol::Real, reltol::Real) where T <: Real
    isempty(cur_range) && return Real[]

    cur_roots = find_bisection_roots(f, cur_range, abstol, reltol)
    isempty(cur_roots) || return cur_roots

    cur_root = find_order_root(f, cur_range, abstol, reltol)
    isnan(cur_root) && return Real[]

    cur_roots = [cur_root]
    cur_roots
end

function find_bisection_roots(f, cur_range::AbstractVector{T}, abstol::Real, reltol::Real) where T <: Real
    no_pts = length(cur_range)

    root_list = Real[]

    cur_values = f.(cur_range)

    cur_signs = map(sign, cur_values[1:end-1] .* cur_values[2:end])

    for (cur_index, cur_sign) in enumerate(cur_signs)
        isinf(cur_sign) && continue

        cur_a, cur_b = cur_range[cur_index:cur_index+1]

        if iszero(cur_sign)
            iszero(cur_values[cur_index]) && push!(root_list, cur_a)

            ( cur_index == no_pts - 1 ) &&
              iszero(cur_values[cur_index+1]) && push!(root_list, cur_b)

            continue
        end

        ( cur_sign > 0 ) && continue

        push!(root_list, find_zero(f, [cur_a, cur_b], Bisection()))
    end

    root_list
end

function find_order_root(f, cur_range::AbstractVector{T}, abstol::Real, reltol::Real) where T <: Real
    min_value = first(cur_range)
    max_value = last(cur_range)

    cur_guesses = view( cur_range , (3:4:length(cur_range)-2) )

    cur_root = NaN

    for cur_guess in cur_guesses
        tmp_root = NaN

        try
            tmp_root = find_zero(
                f, cur_guess, Order8();
                maxevals=10, abstol=abstol, reltol=reltol
            )
        catch cur_error
            continue
        end

        ( min_value < tmp_root < max_value ) || continue

        isapprox(f(tmp_root), 0.0, atol=abstol) || continue

        cur_root = tmp_root

        break
    end

    cur_root
end

function loose_isapprox(first_value, second_value, atol, rtol)
  isapprox(first_value, second_value, atol=atol) && return true
  isapprox(first_value, second_value, rtol=rtol) && return true

  false
end
