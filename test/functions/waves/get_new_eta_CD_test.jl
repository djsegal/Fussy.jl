@testset "Get New Eta CD Function Tests" begin

  @test isdefined(Fusion, :get_new_eta_CD) == true

  Fusion.load_input(" Z_eff = 1.0 ")
  Fusion.load_input(" n_bar = 0.86 * 1u\"n20\" ")
  Fusion.load_input(" B_0 = 10.0 * 1u\"T\" ")
  Fusion.load_input(" R_0 = 4.0 * 1u\"m\" ")
  Fusion.load_input(" T_k = 17.8 * 1u\"keV\" ")

  Fusion.load_input(" enable_log_lambda_calc = false ")

  actual_value = Fusion.get_new_eta_CD(
    Fusion.R_0 / 1u"m",
    Fusion.B_0 / 1u"T",
    Fusion.T_k / 1u"keV",
    Fusion.default_eta_CD
  )[1]

  expected_value = 0.366623988062387

  @test isapprox(expected_value, actual_value, rtol=5e-4)

end
