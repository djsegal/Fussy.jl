@testset "Wave B M Function Tests" begin

  @test isdefined(Tokamak, :wave_B_M) == true

  Tokamak.load_input(" n_bar = 0.86 * 1u\"n20\" ")
  Tokamak.load_input(" B_0 = 10.0 * 1u\"T\" ")

  test_rho = 0.699431627110233

  expected_value = 12.1191

  actual_value = Tokamak.wave_B_M(test_rho) / 1u"T"

  @test isapprox(expected_value, actual_value, rtol=5e-4)

end
