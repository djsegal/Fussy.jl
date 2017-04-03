@testset "P F Function Tests" begin

  @test isdefined(Tokamak, :P_F) == true

  @test Tokamak.P_F() != Nullable

  actual_value = Tokamak.P_F()

  actual_value /= 1u"MW"

  actual_value /= Tokamak.symbol_dict["R_0"] ^ 3
  actual_value /= Tokamak.symbol_dict["n_bar"] ^ 2
  actual_value /= Tokamak.symbol_dict["sigma_v_hat"]

  actual_value = SymPy.N(actual_value)

  expected_value = Tokamak.K_F()

  @test isapprox(expected_value, actual_value)

end
