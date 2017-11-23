@testset "Wave D Function Tests" begin

  @test isdefined(Tokamak, :wave_D) == true

  Tokamak.load_input(" Z_eff = 1.0 ")
  Tokamak.load_input(" n_bar = 0.86 * 1u\"n20\" ")
  Tokamak.load_input(" B_0 = 10.0 * 1u\"T\" ")
  Tokamak.load_input(" R_0 = 4.0 * 1u\"m\" ")
  Tokamak.load_input(" T_k = 17.8 * 1u\"keV\" ")

  expected_value = 3.83

  actual_value = Tokamak.wave_D()

  @test isapprox(expected_value, actual_value, rtol=5e-4)

end
