@testset "Lcoe Function Tests" begin

  @test isdefined(Tokamak, :lcoe) == true

  Tokamak.load_input(" R_0 = 3.3 * 1u\"m\" ")
  Tokamak.load_input(" B_0 = 9.2 * 1u\"T\" ")
  Tokamak.load_input(" I_M = 8 * 1u\"MA\" ")
  Tokamak.load_input(" T_k = 15 * 1u\"keV\" ")
  Tokamak.load_input(" n_bar = 1.5 * 1u\"n20\" ")

  cur_solution = Dict(
    "R_0" => ( Tokamak.R_0 / 1u"m" ),
    "B_0" => ( Tokamak.B_0 / 1u"T" ),
    "T_k" => ( Tokamak.T_k / 1u"keV" ),
    "eta_CD" => Tokamak.default_eta_CD
  )

  Tokamak.load_input(" eta_CD = $(Tokamak.default_eta_CD) ")

  analyzed_solution = Tokamak.analyze_solved_case(cur_solution, verbose=false)

  magnet_solution = Tokamak.solve_magnet_equations(
    ( analyzed_solution["R_0"] * 1u"m" ),
    ( analyzed_solution["n_bar"] * 1u"n20" ),
    ( analyzed_solution["I_M"] * 1u"MA" )
  )

  MCT = Tokamak.CostTable(
    analyzed_solution=analyzed_solution,
    magnet_solution=magnet_solution
  )

  Tokamak.fill_out_cost_table!(MCT, analyzed_solution)

  Tokamak.update_cost_data_frame!(MCT)

  @test Tokamak.lcoe(MCT) < 250

end
