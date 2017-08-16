"""
    solved_T_k_from_constraint(T_guess, cur_eta_CD, cur_eq, verbose)

Lorem ipsum dolor sit amet.
"""
function solved_T_k_from_constraint(T_guess, cur_eta_CD, cur_eq, verbose)

  T_attempt_list = Array{AbstractFloat}([T_guess])

  for cur_scaling = linspace(2.0, 4.0, T_attempt_count)
    push!(T_attempt_list, T_guess * cur_scaling)
    push!(T_attempt_list, T_guess / cur_scaling)
  end

  solved_T_k = NaN

  did_work = true

  for cur_T_attempt in T_attempt_list
    did_work = true

    try
      solved_T_k = nlsolve(
        @generate_fusion_equation_set(cur_eq, cur_eta_CD), [cur_T_attempt],
        show_trace = false, xtol = ( wave_error_level / 10 ), iterations = 250
      ).zero[1]

      cur_F = calc_possible_values(
        cur_eq,
        cur_T_k=solved_T_k*1u"keV",
        cur_eta_CD=cur_eta_CD
      )

      if !isreal(solved_T_k) || abs(cur_F) > wave_error_level
        did_work = false
      end
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
