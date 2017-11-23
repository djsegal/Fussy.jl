"""
    n_hat()

Lorem ipsum dolor sit amet.
"""
function n_hat()
  cur_n_hat = n_bar

  cur_n_hat *= sqrt(pi)

  cur_n_hat /= 2

  cur_n_hat *= gamma( nu_n + 2.0 )

  cur_n_hat /= gamma( nu_n + 1.5 )

  cur_n_hat
end
