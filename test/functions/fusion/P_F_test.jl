@testset "P F Function Tests" begin

  @test isdefined(Fusion, :P_F) == true

  @test P_F() != Nullable

  actual_value = P_F()

  actual_value /= 1u"MW"

  actual_value /= Fusion.symbol_dict["R_0"] ^ 3
  actual_value /= Fusion.symbol_dict["n_bar"] ^ 2
  actual_value /= Fusion.symbol_dict["sigma_v_hat"]

  actual_value = SymPy.N(actual_value)

  expected_value = K_F()

  @test isapprox(expected_value, actual_value)

end
