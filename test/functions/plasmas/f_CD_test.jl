@testset "F CD Function Tests" begin

  @test isdefined(Fusion, :f_CD) == true

  Fusion.load_input(" eta_CD = $(default_eta_CD) ")

  actual_value = f_CD()

  actual_value /= Fusion.symbol_dict["n_bar"]
  actual_value /= Fusion.symbol_dict["R_0"] ^ 2
  actual_value /= Fusion.symbol_dict["sigma_v_hat"]

  actual_value *= Fusion.symbol_dict["I_M"]

  actual_value /= eta_CD

  actual_value = SymPy.N(actual_value)

  expected_value = K_CD()

  @test isapprox(expected_value, actual_value)

end
