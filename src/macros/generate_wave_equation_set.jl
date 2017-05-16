"""
    @generate_wave_equation_set

Lorem ipsum dolor sit amet.
"""
macro generate_wave_equation_set(cur_solved_R_0, cur_solved_B_0)
  quote
    function wave_equation_set!(cur_vars, cur_F)
      gamma0 = 8.562
      coeff = 1.0

      n_para = cur_vars[1]
      rho = cur_vars[2]
      omega_nor2 = cur_vars[3]

      cur_wave_chi = subs(wave_chi(rho),
        symbol_dict["R_0"] => $cur_solved_R_0,
        symbol_dict["B_0"] => $cur_solved_B_0
      )

      cur_F[1] = coeff*n_para.^2
      cur_F[1] -= ( (1-(1-omega_nor2).*cur_wave_chi./omega_nor2 ).^0.5 + cur_wave_chi.^0.5 ).^2

      cur_F[2] = omega_nor2
      cur_F[2] -= 0.5*cur_wave_chi./(1+cur_wave_chi)
      cur_F[2] -= 0.5*( cur_wave_chi.^2./(1+cur_wave_chi).^2 + 4*gamma0^2*cur_wave_chi.^3./(1+cur_wave_chi) ).^0.5

      cur_F[3] = (1+nu_T)
      cur_F[3] *= (1-rho.^2).^nu_T.*n_para.^2
      cur_F[3] -= 28.4./( T_k / 1u"keV" )
    end
  end
end
