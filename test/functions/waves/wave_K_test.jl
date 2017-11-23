@testset "Wave K Function Tests" begin

  @test isdefined(Fusion, :wave_K) == true

  Fusion.load_input(" Z_eff = 1.0 ")
  Fusion.load_input(" n_bar = 0.86 * 1u\"n20\" ")
  Fusion.load_input(" B_0 = 10.0 * 1u\"T\" ")
  Fusion.load_input(" R_0 = 4.0 * 1u\"m\" ")
  Fusion.load_input(" T_k = 17.8 * 1u\"keV\" ")

  expected_value = 2.121320343559642

  actual_value = wave_K()

  @test isapprox(expected_value, actual_value, rtol=5e-4)

end
