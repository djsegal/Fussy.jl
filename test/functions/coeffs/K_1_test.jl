@testset "K 1 Function Tests" begin

  @test isdefined(Fusion, :K_1) == true

  Fusion.load_input( "tau_factor = $( Fusion.max_tau_factor )" )

  Fusion.load_input(" Q = 40 ")
  Fusion.load_input(" f_DT = 0.9 ")

  expected_value = 0.5572

  expected_value /= ( 1 + Fusion.f_DT ) / 2

  actual_value = Fusion.K_1()

  @test isapprox( actual_value, expected_value, rtol=1e-3 )

  expected_value = 1.30

  expected_value /= ( 1 + Fusion.f_DT ) / 2

  expected_value *= Fusion.A ^ 0.19

  expected_value *= 1 + Fusion.nu_n + Fusion.nu_T

  expected_value /= 1 + Fusion.nu_n

  expected_value /= 1 + Fusion.nu_T

  expected_value *= Fusion.Q_kernel() ^ 0.31

  cur_kappa_value = 1.0 + Fusion.kappa ^ 2
  cur_kappa_value /= 2

  expected_value *= cur_kappa_value ^ 0.96

  expected_value *= Fusion.kappa ^ 0.09

  expected_value *= Fusion.C_B() ^ 0.96

  expected_value *= Fusion.f_DT ^ 0.62

  expected_value *= Fusion.H

  expected_value *= Fusion.N_G ^ 0.99

  expected_value /= Fusion.epsilon ^ 0.38

  @test isapprox( actual_value, expected_value, rtol=5e-3 )

end
