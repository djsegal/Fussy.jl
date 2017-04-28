"""
    calc_possible_values()

Lorem ipsum dolor sit amet.
"""
function calc_possible_values(cur_value=symbol_dict["sigma_v_hat"], cur_symbol=symbol_dict["sigma_v_hat"])
  cur_sigma_v_hat = sigma_v()

  cur_sigma_v_hat *= 1e21
  cur_sigma_v_hat /= 1u"m^3/s"

  cur_value = subs(cur_value, cur_symbol, cur_sigma_v_hat)

  cur_T_k_value = T_k / 1u"keV"
  cur_T_k_symbol = symbol_dict["T_k"]

  cur_K_CD_denom_value = 1 - K_CD() * cur_sigma_v_hat
  cur_K_CD_denom_symbol = symbol_dict["K_CD_denom"]

  cur_T_k_type = eltype( cur_T_k_value |> NoUnits )

  if cur_T_k_type != SymPy.Sym
    if has(cur_value, cur_T_k_symbol)
      cur_value = subs(cur_value, cur_T_k_symbol, cur_T_k_value)
    end

    if has(cur_value, cur_K_CD_denom_symbol)
      cur_value = subs(cur_value, cur_K_CD_denom_symbol, cur_K_CD_denom_value)
    end

    still_has_symbols = has(cur_value, symbol_dict["R_0"])
    still_has_symbols |= has(cur_value, symbol_dict["B_0"])

    if !still_has_symbols
      cur_value = SymPy.N(cur_value)
    end
  end

  cur_value
end
