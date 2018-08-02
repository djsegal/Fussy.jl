# __precompile__()

module Fussy

  using PmapProgressMeter
  using DataStructures
  using ProgressMeter
  using Parameters
  using SymEngine
  using Polynomials
  using Unitful
  using QuadGK
  using Roots
  using Optim

  using Revise

  include("abstracts.jl")
  include("defaults.jl")

  include("utils/index.jl")

  include("structs/index.jl")
  include("methods/index.jl")

  include("decks/index.jl")
  include("solutions/index.jl")

  export Reactor
  export Study
  export Scan

  function __init__()
    global const rho_sym = symbols(:rho)
    global const eta_CD_sym = symbols(:eta_CD)

    global const symbol_scaling = Dict(
      zip(
        scaling_keys,
        map(cur_key -> symbols("alpha_$cur_key"), scaling_keys)
      )
    )
  end

end
