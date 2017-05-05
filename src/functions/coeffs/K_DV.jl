"""
    K_DV()

Lorem ipsum dolor sit amet.
"""
function K_DV()
  cur_K_DV = 4.0835e3

  cur_K_DV *= N_G ^ 2
  cur_K_DV *= kappa ^ ( 3 // 2 )

  cur_K_DV *= ( 5 + Q )
  cur_K_DV /= ( 5 * Q )

  cur_K_DV *= ( 1 - rho_vol_loss )

  cur_kernel = N_G
  cur_kernel *= kappa ^ ( 3 // 4 )
  cur_kernel *= C_B()

  cur_kernel /= sqrt(epsilon)
  cur_kernel ^= 3.2

  cur_K_DV *= cur_kernel

  cur_K_DV *= b_theta_target()
  cur_K_DV *= sin( divertor_beta )

  cur_K_DV /= 1 + epsilon

  cur_K_DV
end
