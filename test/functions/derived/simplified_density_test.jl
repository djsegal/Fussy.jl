@testset "Simplified Density Function Tests" begin

  @test isdefined(Tokamak, :simplified_density) == true

  Tokamak.load_input( "T_k = 15u\"keV\"" )

  actual_value = Tokamak.simplified_density()
  actual_value /= 1u"n20"
  actual_value *= Tokamak.symbol_dict["R_0"] ^ 2

  expected_value = 1.917 * Tokamak.N_G
  expected_value *= ( Tokamak.sigma_v_hat / 1u"m^3/s" )

  expected_value = 1.591 / ( 1 - expected_value )
  expected_value *= Tokamak.N_G^2
  expected_value *= ( Tokamak.T_k / 1u"keV" )

  actual_value = Tokamak.calculate_sigma_v_hat(actual_value)
  expected_value = Tokamak.calculate_sigma_v_hat(expected_value)

  @test isapprox( expected_value, actual_value , rtol=5e-1 )

end
