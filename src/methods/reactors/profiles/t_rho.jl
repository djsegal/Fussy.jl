function T_rho(cur_reactor::AbstractReactor, cur_rho::AbstractSymbol=rho_sym)
  cur_T_bar = cur_reactor.T_bar

  cur_nu_T = cur_reactor.nu_T

  cur_T_rho = 1 - cur_rho ^ 2

  cur_T_rho ^= cur_nu_T

  cur_T_rho *= cur_T_bar

  cur_T_rho *= 1 + cur_nu_T

  cur_T_rho
end
