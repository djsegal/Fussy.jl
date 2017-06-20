"""
    converge_eta_CD(cur_equations; verbose=false)

Lorem ipsum dolor sit amet.
"""
function converge_eta_CD(cur_equations; verbose=false)
  prev_eta_CD = eta_CD

  cur_solved_R_0 = nothing
  cur_solved_B_0 = nothing

  has_converged = false

  while !has_converged

    cur_solved_R_0 = cur_equations["R_0"]() / 1u"m"
    cur_solved_B_0 = cur_equations["B_0"]() / 1u"T"

    if !enable_eta_CD_derive
      break
    end

    cur_new_eta_CD = get_new_eta_CD(cur_solved_R_0, cur_solved_B_0, verbose=verbose)

    if isnan(cur_new_eta_CD)
      return [ NaN , NaN , NaN ]
    end

    load_input( "eta_CD = $cur_new_eta_CD" )

    rel_error = abs( cur_new_eta_CD - prev_eta_CD )
    rel_error /= cur_new_eta_CD

    prev_eta_CD = cur_new_eta_CD

    has_converged = ( rel_error < 5e-2 )

  end

  output = Array{Any}(3)

  output[1] = cur_solved_R_0
  output[2] = cur_solved_B_0
  output[3] = prev_eta_CD

  return output

end
