"""
    @generate_wave_equation_set

Lorem ipsum dolor sit amet.
"""
macro generate_wave_equation_set(cur_solved_R_0, cur_solved_B_0, cur_solved_T_k, prev_eta_CD)
  quote
    function (cur_var, cur_F)
      rho = cur_var[1]

      cur_n_bar = calc_possible_values(
        ( solved_steady_density() / 1u"n20" ),
        cur_T_k = ( $(esc(cur_solved_T_k)) * 1u"keV" ),
        cur_eta_CD = $(esc(prev_eta_CD))
      )

      cur_wave_chi = subs(
        wave_chi(rho),
        symbol_dict["n_bar"] => cur_n_bar,
        symbol_dict["R_0"] => $(esc(cur_solved_R_0)),
        symbol_dict["B_0"] => $(esc(cur_solved_B_0)),
        symbol_dict["T_k"] => $(esc(cur_solved_T_k))
      )

      cur_n_para = n_para(rho, cur_wave_chi=cur_wave_chi)

      cur_F[1] = cur_n_para^2
      cur_F[1] *= (1+nu_T)
      cur_F[1] *= (1-rho^2)^nu_T
      cur_F[1] -= 28.39/( $(esc(cur_solved_T_k)) )

      cur_F
    end
  end
end
