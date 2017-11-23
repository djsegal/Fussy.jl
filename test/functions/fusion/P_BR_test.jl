@testset "P BR Function Tests" begin

  @test isdefined(Fusion, :P_BR) == true

  @test P_BR() != Nullable

  actual_value = P_BR()

  actual_value /= 1u"MW"

  actual_value /= Fusion.symbol_dict["n_bar"] ^ 2
  actual_value /= Fusion.symbol_dict["T_k"] ^ (1/2)
  actual_value /= Fusion.symbol_dict["R_0"] ^ 3

  actual_value = SymPy.N(actual_value)

  expected_value = K_BR()

  @test isapprox(expected_value, actual_value)

end
