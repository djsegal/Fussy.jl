@testset "K PB Legacy Function Tests" begin

  @test isdefined(Tokamak, :K_PB_legacy) == true

  actual_value = Tokamak.K_PB_legacy()

  expected_value = Tokamak.Q_kernel()
  expected_value *= 5

  expected_value ^= 0.31

  expected_value *= -0.9385

  expected_value *= 1 + Tokamak.nu_n + Tokamak.nu_T

  expected_value /= 1 + Tokamak.nu_n
  expected_value /= 1 + Tokamak.nu_T

  expected_value *= Tokamak.H

  expected_value *= Tokamak.N_G ^ 0.99
  expected_value *= Tokamak.kappa ^ 1.29
  expected_value *= Tokamak.C_B() ^ 0.96

  expected_value /= Tokamak.epsilon ^ 0.38

  @test isapprox(expected_value, actual_value, rtol=5e-3)

  expected_value = -0.5832

  @test isapprox(expected_value, actual_value, rtol=5e-3)

end
