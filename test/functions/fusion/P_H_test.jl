@testset "P H Function Tests" begin

  @test isdefined(Fusion, :P_H) == true

  actual_value = Fusion.P_H()

  actual_value /= Fusion.P_F()

  expected_value = 0.02

  @test isapprox(expected_value, actual_value, rtol=5e-4 )

  Fusion.load_input(" Q = 40 ")

  actual_value = Fusion.P_H()

  actual_value /= Fusion.P_F()

  expected_value = 0.025

  @test isapprox(expected_value, actual_value, rtol=5e-4 )

end
