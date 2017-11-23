@testset "P N Function Tests" begin

  @test isdefined(Fusion, :P_n) == true

  actual_value = Fusion.P_n()

  actual_value /= Fusion.P_F()

  expected_value = 0.8

  @test isapprox(expected_value, actual_value, rtol=5e-3 )

end
