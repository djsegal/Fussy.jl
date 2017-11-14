@testset "Wave B Function Tests" begin

  @test isdefined(Tokamak, :wave_B) == true

  Tokamak.load_input(" n_bar = 0.86 * 1u\"n20\" ")
  Tokamak.load_input(" B_0 = 10.0 * 1u\"T\" ")

  test_rho = 0.699431627110233
  test_theta = 180.0 / 3

  expected_value = 9.1960

  actual_value = Tokamak.wave_B(test_rho, test_theta) / 1u"T"

  @test isapprox(expected_value, actual_value, rtol=5e-4)

end
