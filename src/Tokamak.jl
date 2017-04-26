module Tokamak

  using Julz
  using QuadGK
  using SymPy

  if ( endswith(pwd(), "/test") ) ; cd("..") ; end

  include("../config/bootload.jl")

  function main()
    cur_R_0 = symbol_dict["R_0"]
    cur_B_0 = symbol_dict["B_0"]
    cur_T_k = symbol_dict["T_k"]

    T_list = linspace(1,50,50)

    R_0_2_s = []
    B_0_2_s = []

    R_0_3_s = []
    B_0_3_s = []

    R_0_4_s = []
    B_0_4_s = []

    for cur_T in T_list
      println(cur_T)

      Tokamak.load_input( "T_k = $(cur_T)u\"keV\"" )

      eq_1 = calc_possible_values(r_b_eq_from_ignition())
      eq_2 = calc_possible_values(r_b_eq_from_beta_limit())
      eq_3 = calc_possible_values(r_b_eq_from_wall_loading())
      eq_4 = calc_possible_values(r_b_eq_from_heat_loading())

      println(eq_1)
      println(eq_2)
      println(eq_3)
      println(eq_4)

      println("meh")
      try
        solved_system_2 = SymPy.solve([eq_1, eq_2], [cur_R_0, cur_B_0])[1]
        push!(R_0_2_s, solved_system_2[cur_R_0])
        push!(B_0_2_s, solved_system_2[cur_B_0])
        println("woooo")
      catch
      end

      try
        solved_system_3 = SymPy.solve([eq_1, eq_3], [cur_R_0, cur_B_0])[1]
        push!(R_0_3_s, solved_system_3[cur_R_0])
        push!(B_0_3_s, solved_system_3[cur_B_0])
        println("roooo")
      catch
      end

      try
        solved_system_4 = SymPy.solve([eq_1, eq_4], [cur_R_0, cur_B_0])[1]
        push!(R_0_4_s, solved_system_4[cur_R_0])
        push!(B_0_4_s, solved_system_4[cur_B_0])
        println("moooo")
      catch
      end
    end

    println(R_0_2_s)
    println(B_0_2_s)

    println(R_0_3_s)
    println(B_0_3_s)

    println(R_0_4_s)
    println(B_0_4_s)

    println("done.")
  end

end
