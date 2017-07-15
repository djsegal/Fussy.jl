"""
    reduced_beta()

Lorem ipsum dolor sit amet.
"""
function reduced_beta()
  cur_reduced_beta = 0.08139

  cur_reduced_beta *= 1 + nu_n
  cur_reduced_beta *= 1 + nu_T
  cur_reduced_beta /= 1 + nu_n + nu_T

  cur_reduced_beta *= ( n_bar / 1u"n20" )
  cur_reduced_beta *= ( T_k / 1u"keV" )
  cur_reduced_beta /= ( B_0 / 1u"T" ) ^ 2

  cur_reduced_beta
end
