@testset "Cryo Operation Function Tests" begin

  @test isdefined(Tokamak, :Cryo_Operation) == true

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

  Tokamak.load_input(" eta_CD = $(Tokamak.default_eta_CD) ")

  cur_solution = Tokamak.solve_magnet_equations(
    Tokamak.R_0, Tokamak.n_bar, Tokamak.I_M
  )

  actual_value = Tokamak.Cryo_Operation(cur_solution=cur_solution)

  expected_value = 2.465831510485003e+06

  @test isapprox(expected_value, actual_value, rtol=5e-4)

end
