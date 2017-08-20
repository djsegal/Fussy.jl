"""
    slow_sigma_v(cur_T_k=T_k)

Lorem ipsum dolor sit amet.
"""
function slow_sigma_v(cur_T_k=T_k)

  cur_func = function (rho)

    cur_value = n_profile(rho)

    cur_value /= ( n_bar / 1u"n20" )

    cur_value ^= 2

    cur_value *= sigma_v_ave(rho, cur_T_k=cur_T_k)

    cur_value *= rho

    cur_value /= 1u"m^3/s"

    cur_value

  end

  if eltype( cur_T_k / 1u"keV" ) == SymPy.Sym
    error("Unable to integrate symbolic functions")
  end

  cur_sigma_v = SymPy.N(
    QuadGK.quadgk(cur_func, integral_zero, integral_one)[1]
  )

  cur_sigma_v *= 1u"m^3/s"

  cur_sigma_v

end
