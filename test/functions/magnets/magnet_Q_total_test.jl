@testset "Magnet Q Total Function Tests" begin

  @test isdefined(Tokamak, :magnet_Q_total) == true

  Tokamak.load_input(" R_0 = 5.7 * 1u\"m\" ")
  Tokamak.load_input(" T_k = 15 * 1u\"keV\" ")
  Tokamak.load_input(" epsilon = 0.2807017544 ")
  Tokamak.load_input(" kappa = 2.0 ")

  # chosen to get P_F = 500
  Tokamak.load_input(" n_bar = 0.55229943350020245 * 1u\"n20\" ")

  actual_value = Tokamak.magnet_Q_total()

  expected_value = 54.766492789088670

  @test isapprox(expected_value, actual_value, rtol=5e-4)

end
