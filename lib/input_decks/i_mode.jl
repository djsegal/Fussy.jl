custom_alpha_a = 2.2 - custom_alpha_R

cur_constant = 0.014

cur_constant /= 0.68 ^ custom_alpha_R

cur_constant /= 0.22 ^ custom_alpha_a

confinement_scaling = Dict(
  "constant" => cur_constant,
  "I_M" => ( 69 // 100 ),
  "R_0" => ( custom_alpha_R ),
  "a" => ( custom_alpha_a ),
  "kappa" => ( 0 // 100 ),
  "n_bar" => ( 17 // 1000 ),
  "B_0" => ( 77 // 100 ),
  "A" => ( 0 // 100 ),
  "P" => ( 29 // 100 )
)

alphas = confinement_scaling
