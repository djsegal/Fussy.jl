@testset "Simplified Current Function Tests" begin

  @test isdefined(Tokamak, :simplified_current) == true

  expected_value = Tokamak.K_I()

  actual_value = Tokamak.simplified_current()

  actual_value /= 1u"MA"

  actual_value /= Tokamak.symbol_dict["T_k"]

  actual_value *= Tokamak.symbol_dict["K_CD_denom"]

  @test isapprox(expected_value, actual_value, rtol=5e-4)

end
