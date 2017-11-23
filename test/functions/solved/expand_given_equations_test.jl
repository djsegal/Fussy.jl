@testset "Expand Given Equations Function Tests" begin

  @test isdefined(Fusion, :expand_given_equations!) == true

  Fusion.load_input(" enable_radius_merging = false ")

  expected_value = 1.0

  cur_given_equations = Dict(
    "R_0" => Fusion.symbol_dict["G_K_1"] / Fusion.symbol_dict["G_K_2"],
    "B_0" => Fusion.symbol_dict["R_0"] / Fusion.symbol_dict["B_0"]
  )

  cur_primary_constraint = "steady"
  cur_secondary_constraint = "beta"

  Fusion.expand_given_equations!(cur_given_equations, cur_primary_constraint, cur_secondary_constraint)

  expected_value = 1.0

  actual_value = cur_given_equations["R_0"]

  actual_value *= Fusion.G_2()

  actual_value *= Fusion.K_2()

  actual_value /= Fusion.G_1()

  actual_value /= Fusion.K_1()

  @test isapprox( actual_value, expected_value, rtol=1e-4 )

  actual_value = cur_given_equations["B_0"]

  actual_value *= Fusion.symbol_dict["B_0"]

  actual_value /= Fusion.symbol_dict["R_0"]

  @test isapprox( actual_value, expected_value, rtol=1e-4 )

end
