module Tokamak

  using Julz
  using QuadGK
  using SymPy
  using ProgressMeter

  if ( endswith(pwd(), "/test") ) ; cd("..") ; end

  include("../config/bootload.jl")

  function main(num_points=50)
    cur_R_0 = symbol_dict["R_0"]
    cur_B_0 = symbol_dict["B_0"]
    cur_T_k = symbol_dict["T_k"]

    ignition_relation = r_b_eq_hard_coded()

    solved_equations = [
      r_b_eq_from_beta_limit,
      r_b_eq_from_wall_loading,
      r_b_eq_from_heat_loading
    ]

    Tokamak.load_input( "beta_N = $(Tokamak.max_beta_N)" )
    Tokamak.load_input( "P_W = $( Tokamak.max_P_W / ( 1u"MW" / 1u"m^2" ) ) * ( 1u\"MW\" / 1u\"m^2\" )" )
    Tokamak.load_input( "h_parallel = $( Tokamak.max_h_parallel / ( 1u"MW" * 1u"T" / 1u"m" ) ) * ( 1u\"MW\" * 1u\"T\" / 1u\"m\" )" )

    solved_R_0_s = map(
      cur_eq -> solve(cur_eq(), cur_R_0)[1],
      solved_equations
    )

    solved_ignitions = map(
      solved_R_0 -> subs(ignition_relation, cur_R_0, solved_R_0)
      , solved_R_0_s)

    T_list = logspace(0,2,num_points)

    R_0_lists = [ [] for i=1:length(solved_equations) ]
    B_0_lists = [ [] for i=1:length(solved_equations) ]

    @showprogress 1 "Computing..." for cur_T in T_list
      Tokamak.load_input( "T_k = $(cur_T)u\"keV\"" )

      cur_ignitions = map(
        solved_ignition -> calc_possible_values(solved_ignition),
        solved_ignitions
      )

      solved_B_0_s = map(
        cur_ignition -> solve(cur_ignition, cur_B_0),
        cur_ignitions
      )

      for (cur_index, solved_B_0) in enumerate(solved_B_0_s)
        if length(solved_B_0) == 0
          continue
        end

        solved_B_0 = solved_B_0[1]

        solved_R_0 = calc_possible_values(
          subs(solved_R_0_s[cur_index], cur_B_0, solved_B_0)
        )

        push!(R_0_lists[cur_index], solved_R_0)
        push!(B_0_lists[cur_index], solved_B_0)
      end
    end

    for (cur_index, solved_eq) in enumerate(solved_equations)
      println("\n$(solved_eq)\n")
      println("R_0 = ")
      println(R_0_lists[cur_index])
      println("B_0 = ")
      println(B_0_lists[cur_index])
    end

    println("done.")
  end

end
