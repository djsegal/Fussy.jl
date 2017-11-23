@testset "P Kappa Function Tests" begin

  @test isdefined(Fusion, :P_kappa) == true

  actual_value = Fusion.P_kappa()

  actual_value /= 1u"MW"

  actual_value /= Fusion.symbol_dict["R_0"] ^ 3
  actual_value /= Fusion.symbol_dict["n_bar"]
  actual_value /= Fusion.symbol_dict["T_k"]

  actual_value *= Fusion.symbol_dict["tau_E"]

  actual_value = SymPy.N(actual_value)

  expected_value = Fusion.K_kappa()

  @test isapprox(expected_value, actual_value)

end
