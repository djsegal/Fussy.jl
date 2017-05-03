"""
    heat_load_limit()

Lorem ipsum dolor sit amet.
"""
function heat_load_limit()
  cur_heat_load = P_kappa()
  cur_heat_load += power_balance()

  cur_n_bar = symbol_dict["n_bar"]
  cur_simplified_density = simplified_density()
  cur_simplified_density /= 1u"n20"

  cur_heat_load /= 1u"MW"
  cur_heat_load = subs(cur_heat_load, cur_n_bar, cur_simplified_density)
  cur_heat_load *= 1u"MW"

  cur_heat_load *= ( 1 - rho_vol_loss )

  cur_heat_load *= 3/2 * u"1/mm"

  b_core_term = mu_0
  b_core_term *= simplified_current()
  b_core_term /= ( 2 * pi )

  cur_b_theta = b_theta(1.0)
  cur_b_theta *= b_core_term
  cur_b_theta /= a_bar()

  cur_b_theta_target = b_theta_target()
  cur_b_theta_target *= b_core_term
  cur_b_theta_target /= ( a() * kappa )

  cur_b_theta /= 1u"T"
  cur_b_theta_target /= 1u"T"

  cur_heat_load *= cur_b_theta ^ ( 12 // 10 )

  cur_heat_load /= 2 * pi
  cur_heat_load /= ( R_0 + a() )

  cur_heat_load *= cur_b_theta_target
  cur_heat_load /= cur_b_theta

  cur_heat_load *= sin( divertor_beta )

  cur_heat_load = uconvert(u"MW/m^2", cur_heat_load)

  cur_heat_load -= h_parallel

  cur_heat_load
end
