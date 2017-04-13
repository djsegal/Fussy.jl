@testset "P N Function Tests" begin

  @test isdefined(Tokamak, :P_n) == true

  actual_value = Tokamak.P_n()

  actual_value /= Tokamak.P_F()

  expected_value = 0.8

  @test isapprox(expected_value, actual_value, rtol=5e-3 )

end
