"""
    greenwald_limit()

Lorem ipsum dolor sit amet.
"""
function greenwald_limit()
  cur_greenwald_limit = N_G

  cur_greenwald_limit *= ( I_M / 1u"MA" )

  cur_greenwald_limit /= pi

  cur_greenwald_limit /= ( a() / 1u"m" ) ^ 2

  cur_greenwald_limit -= n_bar / 1u"n20"

  cur_greenwald_limit
end
