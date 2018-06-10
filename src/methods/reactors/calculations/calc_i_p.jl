function calc_I_P(cur_reactor::AbstractReactor)
  if cur_reactor.is_pulsed
    cur_I = _calc_I_P_pulsed(cur_reactor)
  else
    cur_I = _calc_I_P_steady(cur_reactor)
  end

  cur_I *= cur_reactor.T_bar

  cur_I
end

function _calc_I_P_pulsed(cur_reactor::AbstractReactor)
  cur_G_PU = G_PU(cur_reactor)

  cur_numerator = G_PU(cur_reactor) * ( K_BS(cur_reactor) )

  cur_denominator = G_PU(cur_reactor) * ( 1 - K_CD(cur_reactor) * cur_reactor.sigma_v )

  cur_numerator += G_V(cur_reactor) * K_VT(cur_reactor)

  cur_denominator -= G_V(cur_reactor) * K_VI(cur_reactor)

  cur_numerator += G_CS(cur_reactor) * K_CS(cur_reactor)

  cur_I = cur_numerator

  cur_I /= cur_denominator

  cur_I
end

function _calc_I_P_steady(cur_reactor::AbstractReactor)
  cur_numerator = ( K_BS(cur_reactor) )

  cur_denominator = ( 1 - K_CD(cur_reactor) * cur_reactor.sigma_v )

  cur_I = cur_numerator

  cur_I /= cur_denominator

  cur_I
end
