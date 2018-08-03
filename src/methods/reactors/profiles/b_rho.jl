@symbol_func function B_rho(cur_reactor::AbstractReactor, cur_rho::AbstractSymbol, cur_theta::AbstractSymbol)
  cur_angle = cur_theta * ( cur_reactor.pi / 180.0 )

  cur_B = cur_reactor.B_0

  cur_B /= 1 + cur_reactor.epsilon * cur_rho * cos(cur_angle)

  cur_B
end
