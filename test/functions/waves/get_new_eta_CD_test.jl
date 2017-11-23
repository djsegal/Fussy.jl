@testset "Get New Eta CD Function Tests" begin

  @test isdefined(Tokamak, :get_new_eta_CD) == true

  Tokamak.load_input(" Z_eff = 1.0 ")
  Tokamak.load_input(" n_bar = 0.86 * 1u\"n20\" ")
  Tokamak.load_input(" B_0 = 10.0 * 1u\"T\" ")
  Tokamak.load_input(" R_0 = 4.0 * 1u\"m\" ")
  Tokamak.load_input(" T_k = 17.8 * 1u\"keV\" ")

  Tokamak.load_input(" enable_log_lambda_calc = false ")

  actual_value = Tokamak.get_new_eta_CD(
    Tokamak.R_0 / 1u"m",
    Tokamak.B_0 / 1u"T",
    Tokamak.T_k / 1u"keV",
    Tokamak.default_eta_CD
  )[1]

  expected_value = 0.366623988062387

  @test isapprox(expected_value, actual_value, rtol=5e-4)

end
