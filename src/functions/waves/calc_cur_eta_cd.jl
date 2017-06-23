"""
    calc_cur_eta_cd(cur_vars...)

Lorem ipsum dolor sit amet.
"""
function calc_cur_eta_cd(cur_vars...)
  n_para_m = cur_vars[1]
  rho_J_m = cur_vars[2]
  omega = cur_vars[3]

  ###############   Calculating efficiency   ##############

  ww = ( Unitful.c0 / 1u"m/s" )./(v_e(rho_J_m).*n_para_m)   #(eqn6)

  # following are (eqn5)

  xt2 = ww.^2*(local_B(rho_J_m)./(B_M(rho_J_m)-local_B(rho_J_m)))

  MM = 1.0
  nn = 0.77
  xr = 3.5

  RR = 1- epsilon^nn*rho_J_m^nn*(xr^2+ww^2)^0.5/(epsilon^nn*rho_J_m^nn*xr+ww)

  mm = 1.38
  cc = 0.389
  CC = 1-exp(-cc^mm*xt2^mm)
  KK = 3.0/Z_eff
  DD = 3.83/Z_eff^0.707

  lnlambda = 19.0
  eta_LH = 0.75

  eta0 = KK/ww+DD+4*ww^2/(5+Z_eff)
  eta_tilde = CC*MM*RR*eta0 #(eqn13)

  cur_eta_CD = (0.06108/lnlambda)*eta_LH*T_profile(rho_J_m)*eta_tilde  #(eqn14)

  cur_eta_CD
end
