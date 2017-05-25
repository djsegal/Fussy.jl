@testset "Lcoe Function Tests" begin

  @test isdefined(Tokamak, :lcoe) == true

  Tokamak.load_input(" R_0 = 3.3 * 1u\"m\" ")
  Tokamak.load_input(" B_0 = 9.2 * 1u\"T\" ")
  Tokamak.load_input(" I_M = 8 * 1u\"MA\" ")
  Tokamak.load_input(" T_k = 15 * 1u\"keV\" ")
  Tokamak.load_input(" n_bar = 1.5 * 1u\"n20\" ")

  MCT = Tokamak.CostTable()

  Tokamak.fill_out_cost_table!(MCT)

  Tokamak.update_cost_data_frame!(MCT)

  @test Tokamak.lcoe(MCT) < 250

end
