@testset "K Kappa Function Tests" begin

  @test isdefined(Tokamak, :K_kappa) == true

  Tokamak.load_input(" f_DT = 0.9 ")

  expected_value = 0.1221

  expected_value /= 2

  expected_value *= ( 1 + Tokamak.f_DT )

  actual_value = Tokamak.K_kappa()

  @test isapprox( actual_value, expected_value, rtol=5e-3 )

  Tokamak.load_input("nu_n = 0.4")
  Tokamak.load_input("nu_T = 1.1")
  Tokamak.load_input("f_DT = 0.9")

  expected_value = 1.054

  actual_value = K_kappa()

  actual_value /= Tokamak.epsilon ^ 2

  actual_value /= Tokamak.kappa

  @test isapprox( actual_value, expected_value, rtol=1e-3 )

end
