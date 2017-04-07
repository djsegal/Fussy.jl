"""
    troyon_beta_limit()

Lorem ipsum dolor sit amet.
"""
function troyon_beta_limit()
  cur_beta_limit = beta_N

  cur_beta_limit *= ( I_M / 1u"MA" )
  cur_beta_limit /= ( B_0 / 1u"T" )
  cur_beta_limit /= ( a() / 1u"m" )

  cur_beta_limit -= reduced_beta()

  cur_beta_limit
end
