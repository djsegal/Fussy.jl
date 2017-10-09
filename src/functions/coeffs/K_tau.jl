"""
    K_tau()

Lorem ipsum dolor sit amet.
"""
function K_tau()
  cur_K_tau = confinement_scaling["constant"]

  cur_K_tau *= H

  cur_K_tau /= tau_factor

  cur_K_tau
end
