@testset "K Law Function Tests" begin

  @test isdefined(Fusion, :K_law) == true

  Fusion.load_input(" Q = 40 ")
  Fusion.load_input(" f_DT = 0.9 ")

  expected_value = 0.0214

  expected_value *= ( 1 + f_DT ) / 2

  actual_value = K_law()

  @test isapprox(actual_value, expected_value, rtol=5e-3)

  expected_value = 3.41e-3

  expected_value *= 1 + nu_n
  expected_value *= 1 + nu_T
  expected_value /= 1 + nu_n + nu_T

  expected_value /= Q_kernel()

  expected_value *= ( 1 + f_DT ) / 2

  expected_value /= f_DT ^ 2

  @test isapprox(actual_value, expected_value, rtol=5e-3)

end
