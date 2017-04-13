@testset "K N G Function Tests" begin

  @test isdefined(Tokamak, :K_N_G) == true

  actual_value = Tokamak.K_N_G()

  expected_value = 0.3183

  expected_value *= Tokamak.N_G

  expected_value /= Tokamak.epsilon ^ 2

  @test isapprox(expected_value, actual_value, rtol=5e-3)

  expected_value = 4.074

  @test isapprox(expected_value, actual_value, rtol=5e-3)

end
