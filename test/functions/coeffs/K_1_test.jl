@testset "K 1 Function Tests" begin

  @test isdefined(Tokamak, :K_1) == true

  Tokamak.load_input(" Q = 40 ")
  Tokamak.load_input(" f_DT = 0.9 ")

  actual_value = Tokamak.K_1()

  @test isapprox( actual_value, 0.5572, rtol=5e-4 )

  expected_value = 1.30

  expected_value *= Tokamak.A ^ 0.19

  expected_value *= 1 + Tokamak.nu_n + Tokamak.nu_T

  expected_value /= 1 + Tokamak.nu_n

  expected_value /= 1 + Tokamak.nu_T

  expected_value *= Tokamak.Q_kernel() ^ 0.31

  cur_kappa_value = 1.0 + Tokamak.kappa ^ 2
  cur_kappa_value /= 2

  expected_value *= cur_kappa_value ^ 0.96

  expected_value *= Tokamak.kappa ^ 0.09

  expected_value *= Tokamak.C_B() ^ 0.96

  expected_value *= Tokamak.f_DT ^ 0.62

  expected_value *= Tokamak.H

  expected_value *= Tokamak.N_G ^ 0.99

  expected_value /= Tokamak.epsilon ^ 0.38

  @test isapprox( actual_value, expected_value, rtol=5e-3 )

end
