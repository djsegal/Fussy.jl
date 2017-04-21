"""
    calc_sigma_v_hat_value()

Lorem ipsum dolor sit amet.
"""
function calc_sigma_v_hat_value(cur_value=symbol_dict["sigma_v_hat"], cur_symbol=symbol_dict["sigma_v_hat"])
  cur_sigma_v_hat = sigma_v()

  cur_sigma_v_hat *= 10^21
  cur_sigma_v_hat /= 1u"m^3/s"

  cur_value = subs(cur_value, cur_symbol, cur_sigma_v_hat)

  cur_T_k_value = T_k / 1u"keV"
  cur_T_k_symbol = Tokamak.symbol_dict["T_k"]

  cur_T_k_type = eltype( cur_T_k_value |> NoUnits )

  if cur_T_k_type != SymPy.Sym
    if has(cur_value, cur_T_k_symbol)
      cur_value = subs(cur_value, cur_T_k_symbol, cur_T_k_value)
    end
    cur_value = SymPy.N(cur_value)
  end

  cur_value
end
