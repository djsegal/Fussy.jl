"""
    confinement_time_from_scaling()

Lorem ipsum dolor sit amet.
"""
function confinement_time_from_scaling()
  cur_tau_E = H

  cur_tau_E *= confinement_scaling["constant"]

  cur_tau_E *= ( I_M / 1u"MA" ) ^ confinement_scaling["I_M"]
  cur_tau_E *= ( R_0 / 1u"m" ) ^ confinement_scaling["R_0"]
  cur_tau_E *= ( a() / 1u"m" ) ^ confinement_scaling["a"]

  cur_tau_E *= kappa ^ confinement_scaling["kappa"]

  cur_tau_E *= ( n_bar / 1u"n20" ) ^ confinement_scaling["n_bar"]
  cur_tau_E *= ( B_0 / 1u"T" ) ^ confinement_scaling["B_0"]

  cur_tau_E *= A ^ confinement_scaling["A"]

  cur_tau_E /= ( power_sources() / 1u"MW" ) ^ confinement_scaling["P"]

  cur_tau_E *= 1u"s"

  cur_tau_E
end
