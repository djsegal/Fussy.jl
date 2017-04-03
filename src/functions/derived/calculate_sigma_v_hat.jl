"""
    calculate_sigma_v_hat()

Lorem ipsum dolor sit amet.
"""
function calculate_sigma_v_hat(cur_value=symbol_dict["sigma_v_hat"])
  cur_sigma_v_hat = sigma_v()
  cur_sigma_v_hat *= 10^21
  cur_sigma_v_hat /= 1u"m^3/s"

  cur_symbol = symbol_dict["sigma_v_hat"]

  cur_value = subs(cur_value, cur_symbol, cur_sigma_v_hat)

  cur_T_k_type = eltype( T_k / 1u"keV" |> NoUnits )

  if cur_T_k_type != SymPy.Sym
    cur_value = SymPy.N(cur_value)
  end

  cur_value
end
