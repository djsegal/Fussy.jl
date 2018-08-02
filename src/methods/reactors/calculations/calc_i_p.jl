function calc_I_P(cur_reactor::AbstractReactor)
  if cur_reactor.is_pulsed
    cur_I = _calc_I_P_pulsed(cur_reactor)
  else
    cur_I = _calc_I_P_steady(cur_reactor)
  end

  cur_I *= cur_reactor.T_bar

  cur_I
end

function calc_I_P(cur_reactor::AbstractReactor, cur_constraint::Symbol)
  cur_symbol = Symbol("I_P_from_beta_$(cur_constraint)")

  cur_function = getfield(Fussy, cur_symbol)

  cur_I = cur_function(cur_reactor)

  cur_I
end

function _calc_I_P_pulsed(cur_reactor::AbstractReactor)
  cur_G_PU = G_PU(cur_reactor)

  cur_G_V = G_V(cur_reactor)

  cur_numerator = cur_G_PU * ( K_BS(cur_reactor) )

  cur_denominator = cur_G_PU * ( 1 - K_CD(cur_reactor) * cur_reactor.sigma_v )

  cur_numerator += cur_G_V * K_VT(cur_reactor)

  cur_denominator -= cur_G_V * K_VI(cur_reactor)

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
