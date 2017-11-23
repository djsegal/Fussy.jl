@testset "Make Given Equations Function Tests" begin

  @test isdefined(Fusion, :make_given_equations) == true

  Fusion.load_input(" enable_radius_merging = false ")

  expected_value = 1.0

  # -----------
  #  R_0 Tests
  # -----------

  # reversibility

  actual_value = Fusion.make_given_equations("steady", "wall")["R_0"]

  actual_value /= Fusion.make_given_equations("steady", "beta")["R_0"]

  @test isapprox( actual_value, expected_value, rtol=1e-4 )

  # 1 - steady

  actual_value = Fusion.make_given_equations("steady", "wall")["R_0"]

  actual_value ^= 0.16

  actual_value /= ( Fusion.B_0 / 1u"T" ) ^ 0.15

  actual_value /= Fusion.symbol_dict["G_K_1"]

  @test isapprox( actual_value, expected_value, rtol=1e-4 )

  # 2 - beta

  actual_value = Fusion.make_given_equations("beta", "steady")["R_0"]

  actual_value *= ( Fusion.B_0 / 1u"T" )

  actual_value /= Fusion.symbol_dict["G_K_2"]

  @test isapprox( actual_value, expected_value, rtol=1e-4 )

  # 3 - wall

  actual_value = Fusion.make_given_equations("wall", "steady")["R_0"]

  actual_value ^= 3

  actual_value /= Fusion.symbol_dict["G_K_3"]

  @test isapprox( actual_value, expected_value, rtol=1e-4 )

  # -----------
  #  B_0 Tests
  # -----------

  # reversibility

  actual_value = Fusion.make_given_equations("wall", "beta")["B_0"]

  actual_value /= Fusion.make_given_equations("beta", "wall")["B_0"]

  @test isapprox( actual_value, expected_value, rtol=1e-4 )

  # 1 & 2 - steady + beta

  actual_value = Fusion.make_given_equations("steady", "beta")["B_0"]

  actual_value ^= ( 31 // 100 )

  actual_value *= Fusion.symbol_dict["G_K_1"]

  actual_value /= Fusion.symbol_dict["G_K_2"] ^ ( 16 // 100 )

  @test isapprox( actual_value, expected_value, rtol=1e-4 )

  # 1 & 3 - steady + wall

  actual_value = Fusion.make_given_equations("steady", "wall")["B_0"]

  actual_value ^= ( 15 // 100 )

  actual_value *= Fusion.symbol_dict["G_K_1"]

  actual_value /= Fusion.symbol_dict["G_K_3"] ^ ( 16 // 300 )

  @test isapprox( actual_value, expected_value, rtol=1e-4 )

end
