module Tokamak

  using Julz
  using QuadGK
  using SymPy
  using DataStructures
  using NLsolve
  using Elliptic
  using Polynomials
  using DataFrames
  using Interpolations
  using YAML
  using Memoize

  Base.cd("$(dirname(@__FILE__))/..") do
    include("../config/bootload.jl")
  end

  function main(num_points=6; min_B=5, max_B=15)
    load_input("input.jl", true)
    load_input("arc.jl", true)

    B_list = linspace(min_B, max_B, num_points)

    load_input(" enable_eta_CD_derive = true ")

    load_input(" use_slow_sigma_v_funcs = true ")

    solved_equations = sweep_B_0(B_list)

    println("")

    println("R_0 = ")
    println(solved_equations["R_0"])

    println("B_0 = ")
    println(solved_equations["B_0"])

    println("T_k = ")
    println(solved_equations["T_k"])

    println("eta_CD = ")
    println(solved_equations["eta_CD"])

    println("constraints = ")
    println(solved_equations["constraint"])

    println("limits = ")
    for cur_key in keys(solved_equations["limits"])
      println("$cur_key: $(solved_equations["limits"][cur_key])")
    end

    println("done.")
  end

end
