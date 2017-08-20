"""
    n_para(rho_J; cur_wave_chi=nothing, cur_omega_nor2=nothing)

Lorem ipsum dolor sit amet.
"""
function n_para(rho_J; cur_wave_chi=nothing, cur_omega_nor2=nothing)

  if cur_wave_chi == nothing
    cur_wave_chi = wave_chi(rho_J)
  end

  if cur_omega_nor2 == nothing
    cur_omega_nor2 = omega_nor2(rho_J, cur_wave_chi)
  end

  cur_n_para = sqrt(
    (
      sqrt(cur_wave_chi) +
      (
        1 -
        (
          ( 1 - cur_omega_nor2 ) *
          ( cur_wave_chi / cur_omega_nor2 )
        )
      ) ^ 0.5
    ) ^ 2
  )

  cur_n_para

end
