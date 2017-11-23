@testset "G 1 Function Tests" begin

  @test isdefined(Fusion, :G_1) == true

  expected_value = Fusion.K_nu()

  actual_value = Fusion.G_1()

  actual_value *= Fusion.symbol_dict["sigma_v_hat"] ^ 0.69

  actual_value *= Fusion.symbol_dict["T_k"] ^ 0.04

  actual_value *= Fusion.symbol_dict["K_CD_denom"] ^ 0.96

  actual_value -= Fusion.symbol_dict["sigma_v_hat"]

  actual_value /= sqrt( Fusion.symbol_dict["T_k"] )

  actual_value /= -1

  @test isapprox(expected_value, actual_value, rtol=5e-4)

end
