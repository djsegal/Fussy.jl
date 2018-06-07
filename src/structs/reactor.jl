@with_kw mutable struct Reactor <: AbstractReactor
  T_bar::AbstractSymbol

  n_bar::AbstractSymbol = symbols(:n_bar)
  I_P::AbstractSymbol = symbols(:I_P)

  R_0::AbstractSymbol = symbols(:R_0)
  B_0::AbstractSymbol = symbols(:B_0)

  sigma_v::AbstractSymbol = symbols(:sigma_v)

  mode_scaling::Dict = h_mode_scaling

  deck::Union{Void, Symbol} = nothing

  is_pulsed::Bool = true
  is_symbolic::Bool = false

  is_solved::Bool = false
  is_good::Bool = true

  H::AbstractSymbol = 1.1
  Q::AbstractSymbol = 39.86

  epsilon::AbstractSymbol = 0.3226
  kappa_95::AbstractSymbol = 1.590
  delta_95::AbstractSymbol = 0.333

  b::AbstractSymbol = 1.2

  nu_n::AbstractSymbol = 0.27
  nu_T::AbstractSymbol = 1.094

  Z_eff::AbstractSymbol = 2.584
  f_D::AbstractSymbol = 0.7753

  A::AbstractSymbol = 2.735

  l_i::AbstractSymbol = 1.155

  rho_m::AbstractSymbol = symbols(:rho_m)
  gamma::AbstractSymbol = symbols(:gamma)

  N_G::AbstractSymbol = 1.2

  eta_T::AbstractSymbol = 0.3531
  eta_RF::AbstractSymbol = 0.4

  tau_RU::AbstractSymbol = 15.0
  tau_RD::AbstractSymbol = 15.0
  tau_DW::AbstractSymbol = 1800.0

  tau_FT::AbstractSymbol = 7273.0
  C_ejima::AbstractSymbol = 0.3

  pi::AbstractSymbol = AbstractFloat(Base.pi)

  B_CS::AbstractSymbol = 12.77

  sigma_CS::AbstractSymbol = 300.0
  sigma_TF::AbstractSymbol = 600.0

  J_CS::AbstractSymbol = 50.0
  J_TF::AbstractSymbol = 200.0

  max_beta_N::AbstractSymbol = 0.02591
  max_q_95::AbstractSymbol = 2.5
  max_q_DV::AbstractSymbol = 10.0
  max_P_E::AbstractSymbol = 1500.0
  max_P_W::AbstractSymbol = 8.0

  tau_E::AbstractCalculated = nothing
  p_bar::AbstractCalculated = nothing
  P_F::AbstractCalculated = nothing

  beta_N::AbstractCalculated = nothing
  q_95::AbstractCalculated = nothing
  q_DV::AbstractCalculated = nothing
  P_E::AbstractCalculated = nothing
  P_W::AbstractCalculated = nothing

  norm_beta_N::AbstractCalculated = nothing
  norm_q_95::AbstractCalculated = nothing
  norm_q_DV::AbstractCalculated = nothing
  norm_P_E::AbstractCalculated = nothing
  norm_P_W::AbstractCalculated = nothing

  f_BS::AbstractCalculated = nothing
  f_CD::AbstractCalculated = nothing
  f_ID::AbstractCalculated = nothing

  resistance::AbstractCalculated = nothing
  voltage::AbstractCalculated = nothing
  inductance::AbstractCalculated = nothing

  volume::AbstractCalculated = nothing

  W_M::AbstractCalculated = nothing
  cost::AbstractCalculated = nothing

  eta_CD::AbstractCalculated = nothing

  a::AbstractCalculated = nothing

  constraint::Union{Void, AbstractString} = nothing
end

function _Reactor!(cur_reactor::AbstractReactor, cur_kwargs::Dict)
  for (cur_key, cur_value) in cur_kwargs
    cur_field = getfield(cur_reactor, cur_key)

    value_type = eltype(cur_value)
    field_type = eltype(cur_field)

    if value_type <: Int && !(field_type <: Int)
      cur_value = float(cur_value)
    end

    setfield!(cur_reactor, cur_key, cur_value)
  end

  if cur_reactor.constraint == nothing
    if cur_reactor.is_pulsed
      cur_reactor.constraint = "kink"
    else
      cur_reactor.constraint = "beta"
    end
  end

  isa(cur_reactor.kappa_95, AbstractFloat) || return

  if isa(cur_reactor.l_i, SymEngine.Basic)
    if isa(cur_reactor.rho_m, AbstractFloat)
      isa(cur_reactor.gamma, SymEngine.Basic) &&
        ( cur_reactor.gamma = 1 / ( 1 - cur_reactor.rho_m ) )
    end

    cur_reactor.l_i = int_b_p(cur_reactor.gamma)
    cur_reactor.l_i /= 1 + cur_reactor.kappa_95 ^ 2
    cur_reactor.l_i *= 4 * cur_reactor.kappa_95
  end

  if isa(cur_reactor.gamma, SymEngine.Basic)
    cur_lhs = cur_reactor.l_i
    cur_lhs *= 1 + cur_reactor.kappa_95 ^ 2
    cur_lhs /= 4 * cur_reactor.kappa_95

    cur_gamma = 0.0
    for cur_attempt in 1:10
      cur_gamma = fzero(
        tmp_gamma -> int_b_p(tmp_gamma) - cur_lhs,
        rand()
      )

      iszero(cur_gamma) || break
    end
    cur_reactor.gamma = cur_gamma
  end

  if isa(cur_reactor.rho_m, SymEngine.Basic)
    cur_gamma = cur_reactor.gamma
    if cur_gamma < 1
      cur_reactor.rho_m = 0.0
    else
      cur_reactor.rho_m = sqrt( cur_gamma - 1 )
      cur_reactor.rho_m /= sqrt( cur_gamma )
    end
  end
end

function Reactor(cur_temp::AbstractSymbol; cur_kwargs...)
  cur_dict = Dict(cur_kwargs)

  cur_reactor = Reactor(cur_temp, cur_dict)

  cur_reactor
end

function Reactor(cur_temp::AbstractSymbol, cur_dict::Dict)
  if haskey(cur_dict, :deck) && cur_dict[:deck] != nothing
    cur_deck_symbol = Symbol("$(cur_dict[:deck])_deck")
    cur_deck_func = getfield(FusionSystems, cur_deck_symbol)

    cur_reactor = cur_deck_func(cur_temp)
  else
    cur_reactor = Reactor(T_bar=cur_temp)
  end

  _Reactor!(cur_reactor, cur_dict)

  cur_reactor
end

function _SymbolizeReactor!(cur_reactor::AbstractReactor)
  for cur_field_name in fieldnames(cur_reactor)
    ( cur_field_name == :T_bar ) && continue

    cur_field = getfield(cur_reactor, cur_field_name)
    isa(cur_field, AbstractFloat) || continue

    cur_field = symbols(cur_field_name)
    setfield!(cur_reactor, cur_field_name, cur_field)
  end
end

function _NanizeReactor!(cur_reactor::AbstractReactor)
  for cur_field_name in fieldnames(cur_reactor)
    ( cur_field_name == :T_bar ) && continue

    cur_field = getfield(cur_reactor, cur_field_name)
    isa(cur_field, AbstractFloat) ||
      isa(cur_field, SymEngine.Basic) ||
      continue

    setfield!(cur_reactor, cur_field_name, NaN)
  end
end

function NanReactor(cur_temp::AbstractSymbol, cur_dict::Dict)
  cur_reactor = Reactor(T_bar = cur_temp)

  _NanizeReactor!(cur_reactor)

  cur_reactor
end

function NanReactor(cur_temp::AbstractSymbol=symbols(:T_bar); cur_kwargs...)
  cur_dict = Dict(cur_kwargs)

  cur_reactor = NanReactor(cur_temp, cur_dict)

  cur_reactor
end

function SymbolicReactor(cur_temp::AbstractSymbol=symbols(:T_bar); cur_kwargs...)
  cur_dict = Dict(cur_kwargs)

  cur_scaling = haskey(cur_dict, :mode_scaling) ?
    cur_dict[:mode_scaling] : symbol_scaling

  delete!(cur_dict, :mode_scaling)

  cur_reactor = Reactor(
    T_bar = cur_temp,
    is_symbolic = true,
    mode_scaling = cur_scaling
  )

  _SymbolizeReactor!(cur_reactor)
  _Reactor!(cur_reactor, cur_dict)

  cur_reactor
end

function BaseReactor(cur_temp::AbstractSymbol=symbols(:T_bar); cur_kwargs...)
  cur_dict = Dict(cur_kwargs)

  cur_reactor = Reactor(T_bar = cur_temp)

  _SymbolizeReactor!(cur_reactor)

  cur_reactor.pi = AbstractFloat(Base.pi)

  _Reactor!(cur_reactor, cur_dict)

  cur_reactor
end

Reactor(cur_temp::Number; cur_kwargs...) =
  Reactor(float(cur_temp); cur_kwargs...)

SymbolicReactor(cur_temp::Number; cur_kwargs...) =
  SymbolicReactor(float(cur_temp); cur_kwargs...)

BaseReactor(cur_temp::Number; cur_kwargs...) =
  BaseReactor(float(cur_temp); cur_kwargs...)

NanReactor(cur_temp::Number; cur_kwargs...) =
  NanReactor(float(cur_temp); cur_kwargs...)
