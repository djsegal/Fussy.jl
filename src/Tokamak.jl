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

  if ( endswith(pwd(), "/test") ) ; cd("..") ; end

  if ( endswith(pwd(), "/lib/notebooks") ) ; cd("../..") ; end

  include("../config/bootload.jl")

  function main(num_points=11; min_T=5, max_T=25)
    load_input("input.jl", true)

    T_list = linspace(min_T, max_T, num_points)

    solved_equations = sweep_T_k(T_list)

    for (key, value) in solved_equations
      println("\n$(key)\n")

      println("R_0 = ")
      println(solved_equations[key]["R_0"])

      println("B_0 = ")
      println(solved_equations[key]["B_0"])

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
