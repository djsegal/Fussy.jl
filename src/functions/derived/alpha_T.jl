"""
    alpha_T()

Lorem ipsum dolor sit amet.
"""
function alpha_T()
  cur_alpha_T = 2

  cur_alpha_T *= alphas["P"]

  cur_alpha_T -= alphas["n_bar"]
  cur_alpha_T -= alphas["I_M"]

  cur_alpha_T
end
