"""
    converge_eta_CD(cur_B, cur_equations, T_guess=12.5; verbose=false)

Lorem ipsum dolor sit amet.
"""
function converge_eta_CD(cur_B, cur_equations, T_guess=12.5; verbose=false)
  prev_eta_CD = eta_CD

  cur_solved_R_0 = nothing
  cur_solved_T_k = nothing

  has_converged = false

  while !has_converged

    cur_solved_T_k = cur_equations["T_k"](T_guess, cur_B) / 1u"keV"

    if isnan(cur_solved_T_k)
      if verbose ; print("x") ; end
      return [ NaN , NaN , NaN ]
    end

    cur_solved_R_0 = cur_equations["R_0"](cur_solved_T_k, cur_B) / 1u"m"

    if !enable_eta_CD_derive
      break
    end

    cur_new_eta_CD = get_new_eta_CD(cur_solved_R_0, cur_B, cur_solved_T_k, verbose=verbose)

    if isnan(cur_new_eta_CD)
      return [ NaN , NaN , NaN ]
    end

    load_input( "eta_CD = $cur_new_eta_CD" )

    rel_error = abs( cur_new_eta_CD - prev_eta_CD )
    rel_error /= cur_new_eta_CD

    prev_eta_CD = cur_new_eta_CD

    has_converged = ( rel_error < wave_error_level )

  end

  output = Array{Any}(3)

  output[1] = cur_solved_R_0
  output[2] = cur_solved_T_k
  output[3] = prev_eta_CD

  return output

end
