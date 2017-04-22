@testset "Simplified Density Function Tests" begin

  @test isdefined(Tokamak, :simplified_density) == true

  expected_value = Tokamak.K_n()

  actual_value = Tokamak.simplified_density()

  actual_value /= 1u"n20"

  actual_value /= Tokamak.symbol_dict["T_k"]

  actual_value *= Tokamak.symbol_dict["R_0"] ^ 2

  actual_value *= Tokamak.symbol_dict["K_CD_denom"]

  @test isapprox(expected_value, actual_value, rtol=5e-4)

end
