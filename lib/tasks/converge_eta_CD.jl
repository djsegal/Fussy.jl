"""
    converge_eta_CD(cur_B, cur_equation, prev_eta_CD, T_guess=15.0; verbose=false)

Lorem ipsum dolor sit amet.
"""
function converge_eta_CD(cur_B, cur_equation, prev_eta_CD, T_guess=15.0; verbose=false)
  cur_solved_R_0 = nothing
  cur_solved_T_k = nothing

  has_converged = false

  attempt_bank = []

  while !has_converged

    if length(attempt_bank) >= eta_cd_attempts
      if any(cur_attempt -> !isnan(cur_attempt), attempt_bank)
        println("\nFailed to converge eta CD: \n$(unique(attempt_bank))\n")
      end
      return [ NaN , NaN , NaN ]
    end

    cur_solved_T_k = cur_equation["T_k"](T_guess, cur_B, prev_eta_CD) / 1u"keV"

    if isnan(cur_solved_T_k)
      if verbose ; print("x") ; end
      append!(attempt_bank, [ NaN for i in 1:( eta_cd_attempts - length(attempt_bank) ) ])
      continue
    end

    cur_solved_R_0 = cur_equation["R_0"](cur_solved_T_k, cur_B, prev_eta_CD) / 1u"m"

    if !enable_eta_CD_derive
      break
    end

    cur_new_eta_CD = get_new_eta_CD(cur_solved_R_0, cur_B, cur_solved_T_k, prev_eta_CD, verbose=verbose)

    if isnan(cur_new_eta_CD)
      if verbose ; print("#") ; end
      append!(attempt_bank, [ NaN for i in 1:( eta_cd_attempts - length(attempt_bank) ) ])
      continue
    end

    rel_error = abs( cur_new_eta_CD - prev_eta_CD )
    rel_error /= cur_new_eta_CD

    prev_eta_CD = cur_new_eta_CD

    push!(attempt_bank, cur_new_eta_CD)

    has_converged = ( rel_error < wave_error_level )

  end

  output = Array{Any}(3)

  output[1] = cur_solved_R_0
  output[2] = cur_solved_T_k
  output[3] = prev_eta_CD

  return output

end
