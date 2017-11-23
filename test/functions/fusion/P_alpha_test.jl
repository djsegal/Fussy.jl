@testset "P Alpha Function Tests" begin

  @test isdefined(Fusion, :P_alpha) == true

  actual_value = P_alpha()

  actual_value /= P_F()

  expected_value = 0.2

  @test isapprox(expected_value, actual_value, rtol=1e-2 )

end
