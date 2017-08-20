@testset "F CD Function Tests" begin

  @test isdefined(Tokamak, :f_CD) == true

  Tokamak.load_input(" eta_CD = $(Tokamak.default_eta_CD) ")

  actual_value = Tokamak.f_CD()

  actual_value /= Tokamak.symbol_dict["n_bar"]
  actual_value /= Tokamak.symbol_dict["R_0"] ^ 2
  actual_value /= Tokamak.symbol_dict["sigma_v_hat"]

  actual_value *= Tokamak.symbol_dict["I_M"]

  actual_value /= Tokamak.eta_CD

  actual_value = SymPy.N(actual_value)

  expected_value = Tokamak.K_CD()

  @test isapprox(expected_value, actual_value)

end
