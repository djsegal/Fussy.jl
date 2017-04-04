@testset "H Mode Confinement Time Function Tests" begin

  @test isdefined(Tokamak, :h_mode_confinement_time) == true

  actual_value = Tokamak.h_mode_confinement_time()

  actual_value /= 1u"s"

  actual_value /= Tokamak.symbol_dict["B_0"] ^ ( 15 // 100 )
  actual_value /= Tokamak.symbol_dict["I_M"] ^ ( 93 // 100 )

  actual_value *= Tokamak.symbol_dict["n_bar"] ^ ( 97 // 100 )
  actual_value *= Tokamak.symbol_dict["R_0"] ^ ( 10 // 100 )
  actual_value *= Tokamak.symbol_dict["sigma_v_hat"] ^ ( 69 // 100 )

  expected_value = ( 5 * Tokamak.Q )
  expected_value /= ( 5 + Tokamak.Q )
  expected_value = expected_value ^ 0.69

  expected_value *= 3.550e-3
  expected_value *= Tokamak.H
  expected_value *= Tokamak.kappa ^ 0.09
  expected_value /= Tokamak.epsilon ^ 0.8

  @test isapprox(expected_value, actual_value, rtol=5e-3)

end
