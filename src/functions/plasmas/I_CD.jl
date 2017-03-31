"""
    I_CD(I_M)

Lorem ipsum dolor sit amet.
"""
function I_CD(I_M)
  cur_I_CD = eta_CD
  cur_I_CD /= Q

  cur_I_CD *= P_F(I_M)
  cur_I_CD /= n_bar(I_M)
  cur_I_CD /= R_0

  cur_I_CD
end
