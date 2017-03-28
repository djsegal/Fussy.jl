"""
    I_CD(R_0, I_M)

Lorem ipsum dolor sit amet.
"""
function I_CD(R_0, I_M)
  cur_I_CD = eta_CD
  cur_I_CD /= Q

  cur_I_CD *= P_F(R_0, I_M)
  cur_I_CD /= n_bar(R_0, I_M)
  cur_I_CD /= R_0

  cur_I_CD
end
