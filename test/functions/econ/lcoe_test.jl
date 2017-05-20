@testset "Lcoe Function Tests" begin

  @test isdefined(Tokamak, :lcoe) == true

  Tokamak.load_input(" kappa = 1.8 ")
  Tokamak.load_input(" epsilon = 0.25 ")
  Tokamak.load_input(" R_0 = 3.3 * 1u\"m\" ")
  Tokamak.load_input(" T_k = 15.0 * 1u\"keV\" ")
  Tokamak.load_input(" n_bar = 1.0 * 1u\"n20\" ")

  MCT = Tokamak.CostTable()

  Tokamak.fill_out_cost_table!(MCT)
  Tokamak.update_cost_data_frame!(MCT)

  @test Tokamak.lcoe(MCT) != Nullable

end
