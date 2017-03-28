"""
    f_CD(R_0, I_M)

Lorem ipsum dolor sit amet.
"""
function f_CD(R_0, I_M)
  cur_f_CD = K_CD()

  cur_f_CD *= n_bar(R_0, I_M)
  cur_f_CD *= R_0^2
  cur_f_CD *= sigma_v_hat()
  cur_f_CD /= I_M

  cur_f_CD
end
