@testset "K Law Function Tests" begin

  @test isdefined(Tokamak, :K_law) == true

  Tokamak.load_input(" Q = 40 ")
  Tokamak.load_input(" f_DT = 0.9 ")

  expected_value = 0.0214

  expected_value *= ( 1 + Tokamak.f_DT ) / 2

  actual_value = Tokamak.K_law()

  @test isapprox(actual_value, expected_value, rtol=5e-3)

  expected_value = 3.41e-3

  expected_value *= 1 + Tokamak.nu_n
  expected_value *= 1 + Tokamak.nu_T
  expected_value /= 1 + Tokamak.nu_n + Tokamak.nu_T

  expected_value /= Tokamak.Q_kernel()

  expected_value *= ( 1 + Tokamak.f_DT ) / 2

  expected_value /= Tokamak.f_DT ^ 2

  @test isapprox(actual_value, expected_value, rtol=5e-3)

end
