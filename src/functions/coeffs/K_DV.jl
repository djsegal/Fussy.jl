"""
    K_DV()

Lorem ipsum dolor sit amet.
"""
function K_DV()
  cur_K_DV = 101.0

  cur_K_DV *= N_G ^ 2
  cur_K_DV *= kappa ^ 0.5

  cur_K_DV *= ( 1 - rho_vol_loss )

  cur_kernel = N_G
  cur_kernel *= kappa ^ 0.75
  cur_kernel *= C_B()

  cur_kernel /= sqrt(epsilon)
  cur_kernel ^= 3.2

  cur_K_DV *= cur_kernel

  cur_K_DV *= b_theta_target()
  cur_K_DV *= sin( divertor_beta )

  cur_K_DV /= epsilon ^ 2
  cur_K_DV /= 1 + epsilon

  cur_K_DV
end
