@testset "Lawson Criterion Function Tests" begin

  @test isdefined(Tokamak, :lawson_criterion) == true

  Tokamak.load_input( "T_k = 15u\"keV\"" )

  actual_value = Tokamak.lawson_criterion()

  actual_value /= 1u"s"
  actual_value /= 1u"n20"

  left_denom_value = Tokamak.sigma_v_hat
  left_denom_value /= 1u"m^3/s"

  right_denom_value = ( Tokamak.T_k / 1u"keV" ) ^ (1/2)
  right_denom_value *= Tokamak.K_BR()

  expected_value = left_denom_value
  expected_value -= right_denom_value
  expected_value = 1 / expected_value

  expected_value *= Tokamak.K_L()
  expected_value *= ( Tokamak.T_k / 1u"keV" )

  actual_value = Tokamak.calc_sigma_v_hat_value(actual_value)
  expected_value = Tokamak.calc_sigma_v_hat_value(expected_value)

  @test isapprox( expected_value , actual_value , rtol=5e-5 )

end
