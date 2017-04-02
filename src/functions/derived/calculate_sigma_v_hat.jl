"""
    calculate_sigma_v_hat()

Lorem ipsum dolor sit amet.
"""
function calculate_sigma_v_hat(cur_value=Sym("sigma_v_hat"))
  cur_sigma_v_hat = sigma_v()
  cur_sigma_v_hat *= 10^21
  cur_sigma_v_hat /= 1u"m^3/s"

  cur_symbol = Sym("sigma_v_hat")

  cur_value = subs(cur_value, cur_symbol, cur_sigma_v_hat)
  cur_value = SymPy.N(cur_value)
  cur_value
end
