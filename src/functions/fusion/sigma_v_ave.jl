"""
    sigma_v_ave()

Lorem ipsum dolor sit amet.
"""
function sigma_v_ave()

  ln_T = log( T_k / 1u"keV" )

  k_0 = -60.4593
  k_1 = +6.1371
  k_2 = -0.8609
  k_3 = +0.0356
  k_4 = -0.0045

  cur_sigma_v_ave = k_0

  cur_sigma_v_ave += k_1 * ln_T ^ 1
  cur_sigma_v_ave += k_2 * ln_T ^ 2
  cur_sigma_v_ave += k_3 * ln_T ^ 3
  cur_sigma_v_ave += k_4 * ln_T ^ 4

  cur_sigma_v_ave = exp( cur_sigma_v_ave )

  cur_sigma_v_ave *= 1u"m^3/s"

  cur_sigma_v_ave

end
