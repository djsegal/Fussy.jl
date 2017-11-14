"""
    @generate_wave_equation_set

Lorem ipsum dolor sit amet.
"""
macro generate_wave_equation_set(cur_solved_R_0, cur_solved_B_0, cur_solved_T_k, cur_solved_n_bar)
  quote
    function (cur_var, cur_F)
      cur_rho = abs(cur_var[1])

      cur_T_k = $( esc(cur_solved_T_k) )

      cur_wave_chi = subs(
        wave_chi(cur_rho),
        symbol_dict["n_bar"] => $( esc(cur_solved_n_bar) ),
        symbol_dict["R_0"] => $( esc(cur_solved_R_0) ),
        symbol_dict["B_0"] => $( esc(cur_solved_B_0) ),
        symbol_dict["T_k"] => cur_T_k
      )

      cur_omega_hat_2 = wave_omega_hat_2(
        cur_rho,
        cur_wave_chi = cur_wave_chi
      )

      cur_n_para_2 = wave_n_para_2(
        cur_rho,
        cur_wave_chi = cur_wave_chi,
        cur_omega_hat_2 = cur_omega_hat_2
      )

      cur_lhs = ( 1.0 + nu_T )

      cur_lhs *= ( 1 - cur_rho ^ 2 ) ^ nu_T

      cur_lhs *= cur_n_para_2

      cur_rhs = 28.39

      cur_rhs /= cur_T_k

      cur_F[1] = cur_rhs - cur_lhs

      cur_F
    end
  end
end
