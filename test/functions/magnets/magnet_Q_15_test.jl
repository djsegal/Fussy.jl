@testset "Magnet Q 15 Function Tests" begin

  @test isdefined(Tokamak, :magnet_Q_15) == true

  Tokamak.load_input(" R_0 = 5.7 * 1u\"m\" ")
  Tokamak.load_input(" T_k = 15 * 1u\"keV\" ")
  Tokamak.load_input(" epsilon = 0.2807017544 ")
  Tokamak.load_input(" kappa = 2.0 ")

  Tokamak.load_input(" I_M = 8 * 1u\"MA\" ")
  Tokamak.load_input(" enable_cold_mass_calc = false ")
  Tokamak.load_input(" B_0 = 9.2 * 1u\"T\" ")

  # chosen to get P_F = 500
  Tokamak.load_input( "use_slow_sigma_v_funcs = true" )
  Tokamak.load_input(" n_bar = 0.551186983424829 * 1u\"n20\" ")

  actual_value = Tokamak.magnet_Q_15()

  expected_value = 80.612344086021510

  @test isapprox(expected_value, actual_value, rtol=5e-4)

end
