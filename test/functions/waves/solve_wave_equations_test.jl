@testset "Solve Wave Equations Function Tests" begin

  @test isdefined(Tokamak, :solve_wave_equations) == true

  Tokamak.load_input(" Z_eff = 1.0 ")
  Tokamak.load_input(" n_bar = 0.86 * 1u\"n20\" ")
  Tokamak.load_input(" B_0 = 10.0 * 1u\"T\" ")
  Tokamak.load_input(" R_0 = 4.0 * 1u\"m\" ")
  Tokamak.load_input(" T_k = 17.8 * 1u\"keV\" ")

  actual_value = Tokamak.solve_wave_equations(
    ( Tokamak.R_0 / 1u"m" ),
    ( Tokamak.B_0 / 1u"T" ),
    ( Tokamak.T_k / 1u"keV" ),
    ( Tokamak.n_bar / 1u"n20" )
  )

  expected_value = 0.699085306107685

  @test isapprox(expected_value, actual_value, rtol=5e-4)

end
