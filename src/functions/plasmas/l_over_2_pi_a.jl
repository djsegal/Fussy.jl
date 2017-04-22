"""
    l_over_2_pi_a()

Lorem ipsum dolor sit amet.
"""
function l_over_2_pi_a()
  cur_l_over_2_pi_a = kappa ^ 2

  cur_l_over_2_pi_a -= 1
  cur_l_over_2_pi_a *= 2
  cur_l_over_2_pi_a /= pi

  cur_l_over_2_pi_a += 1

  cur_l_over_2_pi_a /= kappa

  cur_l_over_2_pi_a *= a_hat()
  cur_l_over_2_pi_a /= a()

  cur_l_over_2_pi_a
end
