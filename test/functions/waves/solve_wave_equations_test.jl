@testset "Solve Wave Equations Function Tests" begin

  @test isdefined(Fusion, :solve_wave_equations) == true

  Fusion.load_input(" Z_eff = 1.0 ")
  Fusion.load_input(" n_bar = 0.86 * 1u\"n20\" ")
  Fusion.load_input(" B_0 = 10.0 * 1u\"T\" ")
  Fusion.load_input(" R_0 = 4.0 * 1u\"m\" ")
  Fusion.load_input(" T_k = 17.8 * 1u\"keV\" ")

  actual_value = solve_wave_equations(
    ( R_0 / 1u"m" ),
    ( B_0 / 1u"T" ),
    ( T_k / 1u"keV" ),
    ( n_bar / 1u"n20" )
  )

  expected_value = 0.699085306107685

  @test isapprox(expected_value, actual_value, rtol=5e-4)

end
