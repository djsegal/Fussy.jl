"""
    converge_eta_CD(cur_B, cur_equation, prev_eta_CD, T_guess=15.0; verbose=false)

Lorem ipsum dolor sit amet.
"""
function converge_eta_CD(cur_B, cur_equation, prev_eta_CD, T_guess=15.0; verbose=false)
  cur_solved_R_0 = NaN
  cur_solved_T_k = NaN
  cur_rho_j = NaN

  has_converged = false

  attempt_bank = []

  new_weight = 0.3
  work_eta_CD = prev_eta_CD

  while !has_converged

    if length(attempt_bank) >= convergence_attempt_counts
      if any(cur_attempt -> !isnan(cur_attempt), attempt_bank)
        println("\nFailed to converge eta CD: \n$(unique(attempt_bank))\n")
      end
      return [ NaN , NaN , NaN , NaN ]
    end

    cur_solved_T_k = cur_equation["T_k"](T_guess, cur_B, work_eta_CD, verbose=verbose) / 1u"keV"

    if isnan(cur_solved_T_k)
      if verbose ; print("x") ; end
      append!(attempt_bank, [ NaN for i in 1:( convergence_attempt_counts - length(attempt_bank) ) ])
      continue
    end

    cur_solved_R_0 = cur_equation["R_0"](cur_solved_T_k, cur_B, work_eta_CD) / 1u"m"

    if !enable_eta_CD_derive
      break
    end

    cur_new_eta_CD, cur_rho_j = get_new_eta_CD(cur_solved_R_0, cur_B, cur_solved_T_k, prev_eta_CD, verbose=verbose)

    is_bad_eta_CD = isnan(cur_new_eta_CD)
    is_bad_eta_CD |= eltype(cur_new_eta_CD) == SymPy.Sym && is_real(cur_new_eta_CD) == nothing

    if is_bad_eta_CD
      if verbose ; print("#") ; end
      append!(attempt_bank, [ NaN for i in 1:( convergence_attempt_counts - length(attempt_bank) ) ])
      continue
    end

    work_eta_CD *= ( 1 - new_weight )
    work_eta_CD += cur_new_eta_CD * new_weight

    rel_error = abs( cur_new_eta_CD - prev_eta_CD )
    rel_error /= cur_new_eta_CD

    prev_eta_CD = cur_new_eta_CD

    push!(attempt_bank, cur_new_eta_CD)

    has_converged = ( rel_error < wave_error_level )

  end

  output = [
    cur_solved_R_0,
    cur_solved_T_k,
    SymPy.N(prev_eta_CD),
    SymPy.N(cur_rho_j)
  ]

  return output

end
