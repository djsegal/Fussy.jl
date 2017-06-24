module Tokamak

  using Julz
  using QuadGK
  using SymPy
  using DataStructures
  using NLsolve
  using Elliptic
  using Polynomials
  using DataFrames
  using Grid
  using YAML
  using Memoize

  Base.cd("$(dirname(@__FILE__))/..") do
    include("../config/bootload.jl")
  end

  function main(num_points=6; min_B=5, max_B=15)
    load_input("input.jl", true)

    B_list = linspace(min_B, max_B, num_points)

    solved_equations = sweep_B_0(B_list)

    for (key, value) in solved_equations
      println("\n$(key)\n")

      println("R_0 = ")
      println(solved_equations[key]["R_0"])

      println("B_0 = ")
      println(solved_equations[key]["B_0"])

      println("T_k = ")
      println(solved_equations[key]["T_k"])

      println("eta_CD = ")
      println(solved_equations[key]["eta_CD"])

      println("other_limits = ")
      for sub_key in keys(solved_equations)
        println("$sub_key: $(solved_equations[key]["other_limits"][sub_key])")
      end
    end

    println("done.")
  end

end
