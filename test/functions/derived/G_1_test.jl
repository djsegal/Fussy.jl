@testset "G 1 Function Tests" begin

  @test isdefined(Tokamak, :G_1) == true

  expected_value = Tokamak.K_nu()

  actual_value = Tokamak.G_1()

  actual_value *= Tokamak.symbol_dict["sigma_v_hat"] ^ 0.69

  actual_value *= Tokamak.symbol_dict["T_k"] ^ 0.04

  actual_value *= Tokamak.symbol_dict["K_CD_denom"] ^ 0.96

  actual_value -= Tokamak.symbol_dict["sigma_v_hat"]

  actual_value /= sqrt( Tokamak.symbol_dict["T_k"] )

  actual_value /= -1

  @test isapprox(expected_value, actual_value, rtol=5e-4)

end
