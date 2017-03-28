function sigma_v_ave()

  T_m = 296u"keV"
  sigma_m = 5.03u"b"

  cur_sigma_v_ave = 4 * sqrt(2/3)
  cur_sigma_v_ave *= uconvert(u"m^2", sigma_m)
  cur_sigma_v_ave *= sqrt( T_m )
  cur_sigma_v_ave /= sqrt( uconvert(u"MeV/c^2", m_r()) )
  cur_sigma_v_ave *= ( T_m / T ) ^ (2/3)
  cur_sigma_v_ave *= exp( -3 * ( T_m / T ) ^ (1/3) + 2 )

  cur_sigma_v_ave

end
