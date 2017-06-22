"""
    K_H()

Lorem ipsum dolor sit amet.
"""
function K_H()

  cur_dict = confinement_scaling

  cur_K_H = 278.3 ^ ( -cur_dict["P"] )

  cur_K_H *= cur_dict["constant"]

  cur_K_H *= H

  cur_K_H *= 1.564 ^ ( cur_dict["I_M"] )

  cur_K_H *= 0.4979 ^ (
    cur_dict["n_bar"] + 1 - 2 * cur_dict["P"]
  )

  q_kernel = 5 * Q
  q_kernel /= 5 + Q
  q_kernel ^= cur_dict["P"]

  cur_K_H *= q_kernel

  cur_K_H *= kappa ^ (
    5/4 * ( cur_dict["n_bar"] + 1 - 2 * cur_dict["P"] + cur_dict["I_M"] ) + cur_dict["kappa"] - cur_dict["P"]
  )

  cur_K_H *= N_G ^ (
    cur_dict["I_M"] + 2 * ( cur_dict["n_bar"] + 1 - 2 * cur_dict["P"] )
  )

  cur_K_H *= C_B() ^ (
    cur_dict["n_bar"] + 1 - 2 * cur_dict["P"] + cur_dict["I_M"]
  )

  cur_K_H *= A ^ cur_dict["A"]

  cur_K_H /= epsilon ^ (
    3/2 * ( cur_dict["n_bar"] + 1 - 2 * cur_dict["P"] ) - 1/2 * cur_dict["I_M"] - cur_dict["a"] + 2 * cur_dict["P"]
  )

  cur_K_H
end
