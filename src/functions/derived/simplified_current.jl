"""
    simplified_current()

Lorem ipsum dolor sit amet.
"""
function simplified_current()
  eq_1 = greenwald_limit()
  eq_2 = steady_state()

  cur_I_M = symbol_dict["I_M"]
  cur_n_bar = symbol_dict["n_bar"]
  cur_sigma_v_hat = symbol_dict["sigma_v_hat"]

  solved_system = SymPy.solve([eq_1, eq_2], [cur_I_M, cur_n_bar])

  cur_simplified_current = solved_system[1][cur_I_M]

  cur_numerator, cur_denominator = fraction(cur_simplified_current)

  scale_factor = -K_LH() / coeff(cur_denominator, cur_sigma_v_hat)

  cur_numerator *= scale_factor
  cur_denominator *= scale_factor

  @assert isapprox(1, SymPy.N(cur_denominator(cur_sigma_v_hat=>0)))

  cur_simplified_current = cur_numerator / K_CD_denom

  cur_simplified_current *= 1u"MA"

  cur_simplified_current
end
