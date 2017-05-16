"""
    wave_chi(rho)

Lorem ipsum dolor sit amet.
"""
function wave_chi(rho)
  cur_wave_chi = omega_pe2(rho)

  cur_wave_chi /= omega_ce(rho) ^ 2

  cur_wave_chi
end
