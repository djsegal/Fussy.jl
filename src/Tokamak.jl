module Tokamak

  using Julz
  using QuadGK
  using SymPy
  using DataStructures

  if ( endswith(pwd(), "/test") ) ; cd("..") ; end

  if ( endswith(pwd(), "/lib/notebooks") ) ; cd("../..") ; end

  include("../config/bootload.jl")

  function main()
    load_input("input.jl", true)

    cur_T_k = scan_for_R_0(3.3)["T_k"]

    T_list = [cur_T_k]

    solved_equations = sweep_T_k(T_list)

    for (key, value) in solved_equations
      println("\n$(key)\n")

      println("R_0 = ")
      println(solved_equations[key]["R_0"])

      println("B_0 = ")
      println(solved_equations[key]["B_0"])

      println("other_limits = ")
      for sub_key in keys(solved_equations)
        println("$sub_key: $(solved_equations[key]["other_limits"][sub_key])")
      end
    end

    println("done.")
  end

end
