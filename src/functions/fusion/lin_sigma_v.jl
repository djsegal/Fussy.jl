"""
    lin_sigma_v(cur_T_k=T_k)

Lorem ipsum dolor sit amet.
"""
function lin_sigma_v(cur_T_k=T_k)

  cur_k_array = sigma_v_k_array()

  cur_sigma_v = 0.0

  for i in 0:length(cur_k_array)-1

    cur_part = ( 1 + nu_T )

    cur_part *= ( cur_T_k / 1u"keV" )

    cur_part ^= i

    cur_part *= cur_k_array[i+1]

    cur_part /= 2

    cur_part /= ( 1 + 2 * nu_n + i * nu_T )

    cur_sigma_v += cur_part

  end

  cur_sigma_v *= ( 1 + nu_n ) ^ 2

  cur_sigma_v *= 1u"m^3/s"

  cur_sigma_v

end
