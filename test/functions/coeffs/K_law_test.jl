@testset "K Law Function Tests" begin

  @test isdefined(Fusion, :K_law) == true

  Fusion.load_input(" Q = 40 ")
  Fusion.load_input(" f_DT = 0.9 ")

  expected_value = 0.0214

  expected_value *= ( 1 + Fusion.f_DT ) / 2

  actual_value = Fusion.K_law()

  @test isapprox(actual_value, expected_value, rtol=5e-3)

  expected_value = 3.41e-3

  expected_value *= 1 + Fusion.nu_n
  expected_value *= 1 + Fusion.nu_T
  expected_value /= 1 + Fusion.nu_n + Fusion.nu_T

  expected_value /= Fusion.Q_kernel()

  expected_value *= ( 1 + Fusion.f_DT ) / 2

  expected_value /= Fusion.f_DT ^ 2

  @test isapprox(actual_value, expected_value, rtol=5e-3)

end
