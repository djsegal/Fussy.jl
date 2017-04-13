@testset "P Alpha Function Tests" begin

  @test isdefined(Tokamak, :P_alpha) == true

  actual_value = Tokamak.P_alpha()

  actual_value /= Tokamak.P_F()

  expected_value = 0.2

  @test isapprox(expected_value, actual_value, rtol=1e-2 )

end
