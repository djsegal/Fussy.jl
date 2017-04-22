"""
    simplified_density()

Lorem ipsum dolor sit amet.
"""
function simplified_density()
  cur_I_M = symbol_dict["I_M"]
  cur_n_bar = symbol_dict["n_bar"]

  cur_simplified_current = simplified_current()
  cur_simplified_current /= 1u"MA"

  cur_greenwald_limit = subs( greenwald_limit() , cur_I_M , cur_simplified_current )

  cur_simplified_density = solve( cur_greenwald_limit , cur_n_bar )[1]

  cur_simplified_density *= 1u"n20"

  cur_simplified_density
end
