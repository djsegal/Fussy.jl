@testset "K Kappa Function Tests" begin

  @test isdefined(Fusion, :K_kappa) == true

  Fusion.load_input(" f_DT = 0.9 ")

  expected_value = 0.1221

  expected_value /= 2

  expected_value *= ( 1 + Fusion.f_DT )

  actual_value = Fusion.K_kappa()

  @test isapprox( actual_value, expected_value, rtol=5e-3 )

end
