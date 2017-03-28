using Unitful
using Unitful.DefaultSymbols

cd = Base.cd

eps_0 = Unitful.ϵ0

module PlasmaUnits
  using Unitful
  import Unitful.DefaultSymbols

  Unitful.@unit n20 "n20" PlasmaDensity 1e20/Unitful.m^3 false
  Unitful.@unit b "b" Barn 1e-28*Unitful.m^2 true
  Unitful.@unit u "u" AMU 1.660539040e-27*Unitful.kg false
end

Unitful.register(PlasmaUnits)
