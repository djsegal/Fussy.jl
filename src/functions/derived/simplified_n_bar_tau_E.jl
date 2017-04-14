"""
    simplified_n_bar_tau_E()

Lorem ipsum dolor sit amet.
"""
function simplified_n_bar_tau_E()
  cur_I_M = simplified_current()
  cur_n_bar = simplified_density()
  cur_tau_E = h_mode_confinement_time()

  cur_I_M /= 1u"MA"
  cur_n_bar /= 1u"n20"
  cur_tau_E /= 1u"s"

  cur_tau_E = subs( cur_tau_E , symbol_dict["n_bar"] , cur_n_bar )
  cur_tau_E = subs( cur_tau_E , symbol_dict["I_M"] , cur_I_M )

  cur_simplified_n_bar_tau_E = cur_n_bar * cur_tau_E

  cur_simplified_n_bar_tau_E *= 1u"n20"
  cur_simplified_n_bar_tau_E *= 1u"s"

  cur_simplified_n_bar_tau_E
end
