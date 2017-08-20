"""
    solved_T_k_from_constraint(T_guess, cur_eta_CD, cur_eq, verbose)

Lorem ipsum dolor sit amet.
"""
function solved_T_k_from_constraint(T_guess, cur_eta_CD, cur_eq, verbose)

  T_attempt_list = Array{AbstractFloat}([T_guess])

  for cur_scaling = (1:T_attempt_count) + 1.0
    push!(T_attempt_list, T_guess * cur_scaling)
    push!(T_attempt_list, T_guess / cur_scaling)
  end

  solved_T_k = NaN

  did_work = true

  cur_error = Inf

  prev_T_k = 0.0

  for cur_T_attempt in T_attempt_list
    did_work = true

    try
      solved_T_k = nlsolve(
        @generate_fusion_equation_set(cur_eq, cur_eta_CD), [cur_T_attempt],
        show_trace = false, xtol=wave_error_level/1e4, ftol=wave_error_level/10, iterations = 250
      ).zero[1]

      cur_error = calc_possible_values(
        cur_eq,
        cur_T_k=solved_T_k*1u"keV",
        cur_eta_CD=cur_eta_CD
      )

      if !isreal(solved_T_k) || abs(cur_error) > wave_error_level
        did_work = false
      end

      if isapprox(prev_T_k, solved_T_k, rtol=wave_error_level/10)
        break
      end

      prev_T_k = solved_T_k
    catch DomainError
      did_work = false
    end

    if verbose ; print( did_work ? "✓" : "." ) ; end

    if did_work ; break ; end
  end

  if !did_work ; solved_T_k = NaN ; end

  solved_T_k *= 1u"keV"

  solved_T_k

end
