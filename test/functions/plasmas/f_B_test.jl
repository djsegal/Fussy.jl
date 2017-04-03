@testset "F B Function Tests" begin

  @test isdefined(Tokamak, :f_B) == true

  @test Tokamak.f_B() != Nullable

  actual_value = Tokamak.f_B()

  actual_value /= Tokamak.symbol_dict["n_bar"]
  actual_value /= Tokamak.symbol_dict["T_k"]
  actual_value /= Tokamak.symbol_dict["R_0"] ^ 2

  actual_value *= Tokamak.symbol_dict["I_M"] ^ 2

  actual_value = SymPy.N(actual_value)

  expected_value = Tokamak.K_B()

  @test isapprox(expected_value, actual_value)

end
