@testset "P H Function Tests" begin

  @test isdefined(Tokamak, :P_H) == true

  actual_value = Tokamak.P_H()

  actual_value /= Tokamak.P_F()

  expected_value = 0.02

  @test isapprox(expected_value, actual_value, rtol=5e-4 )

  Tokamak.load_input(" Q = 40 ")

  actual_value = Tokamak.P_H()

  actual_value /= Tokamak.P_F()

  expected_value = 0.025

  @test isapprox(expected_value, actual_value, rtol=5e-4 )

end
