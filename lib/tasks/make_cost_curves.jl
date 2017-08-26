"""
    make_cost_curves()

Lorem ipsum dolor sit amet.
"""
function make_cost_curves(cur_radii=linspace(2,10,5))

  solution_dict = Dict()

  for cur_radius in cur_radii
    solution_dict[cur_radius] =
      scan_for_R_0(cur_radius, linspace(5,40,3))
  end

  for (cur_radius, cur_solution) in solution_dict

    dememoize()

    analyzed_solution = analyze_solved_case(cur_solution, verbose=false)

    magnet_solution = solve_magnet_equations(
      ( analyzed_solution["R_0"] * 1u"m" ),
      ( analyzed_solution["n_bar"] * 1u"n20" ),
      ( analyzed_solution["I_M"] * 1u"MA" )
    )

    MCT = Tokamak.CostTable(
      ( cur_solution["R_0"] * 1u"m" ),
      ( cur_solution["B_0"] * 1u"T" ),
      ( cur_solution["T_k"] * 1u"keV" ),
      analyzed_solution=analyzed_solution,
      magnet_solution=magnet_solution
    )

    @time Tokamak.fill_out_cost_table!(MCT, analyzed_solution)

    Tokamak.update_cost_data_frame!(MCT)

    println(Tokamak.lcoe(MCT))

  end

end
