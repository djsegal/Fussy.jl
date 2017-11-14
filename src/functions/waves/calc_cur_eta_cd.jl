"""
    calc_cur_eta_cd(cur_vars...)

Lorem ipsum dolor sit amet.
"""
function calc_cur_eta_cd(cur_vars...)
  n_para_m = cur_vars[1]
  rho_J_m = cur_vars[2]
  omega = cur_vars[3]

  ###############   Calculating efficiency   ##############

  # following are (eqn5)

  lnlambda = 19.0

  eta_tilde = wave_C(cur_rho)*wave_M()*wave_R(cur_rho)*wave_eta_0(cur_rho) #(eqn13)

  cur_eta_CD = 0.06108

  cur_eta_CD *= eta_LH

  cur_eta_CD /= lnlambda

  cur_eta_CD *= T_profile(rho_J_m)

  cur_eta_CD *= eta_tilde

  cur_eta_CD
end
