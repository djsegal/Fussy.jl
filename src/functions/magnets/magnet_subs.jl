"""
    magnet_subs(cur_var, cur_R_0, cur_n_bar, cur_I_M, cur_B_0=B_0)

Lorem ipsum dolor sit amet.
"""
function magnet_subs(cur_var, cur_R_0, cur_n_bar, cur_I_M, cur_B_0=B_0)

  if eltype(cur_var) != SymPy.Sym
    return cur_var
  end

  has_bad_var = ( eltype( ( cur_R_0 / 1u"m" ) ) == SymPy.Sym )
  has_bad_var |= ( eltype( ( cur_n_bar / 1u"n20" ) ) == SymPy.Sym )
  has_bad_var |= ( eltype( ( cur_I_M / 1u"MA" ) ) == SymPy.Sym )

  if has_bad_var
    error("Need non-symbolic variables for magnet_subs")
  end

  tmp_var = subs(cur_var,
    symbol_dict["R_0"] => ( cur_R_0 / 1u"m" |> NoUnits ),
    symbol_dict["n_bar"] => ( cur_n_bar / 1u"n20" |> NoUnits ),
    symbol_dict["I_M"] => ( cur_I_M / 1u"MA" |> NoUnits ),
    symbol_dict["B_0"] => ( cur_B_0 / 1u"T" |> NoUnits )
  )

  SymPy.N( tmp_var )

end
