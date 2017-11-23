@testset "F B Function Tests" begin

  @test isdefined(Fusion, :f_B) == true

  actual_value = Fusion.f_B()

  actual_value /= Fusion.symbol_dict["n_bar"]
  actual_value /= Fusion.symbol_dict["T_k"]
  actual_value /= Fusion.symbol_dict["R_0"] ^ 2

  actual_value *= Fusion.symbol_dict["I_M"] ^ 2

  actual_value = SymPy.N(actual_value)

  expected_value = Fusion.K_B()

  @test isapprox(expected_value, actual_value)

end
