"""
    local_T_k(rho, ave_T_k)

Lorem ipsum dolor sit amet.
"""
function local_T_k(rho, ave_T_k)

  cur_local_T = 1.0
  cur_local_T -= rho ^ 2
  cur_local_T ^= nu_T

  cur_local_T *= ( ave_T_k / 1u"keV" )
  cur_local_T *= 1 + nu_T

end
