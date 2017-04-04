@testset "P BR Function Tests" begin

  @test isdefined(Tokamak, :P_BR) == true

  @test Tokamak.P_BR() != Nullable

  actual_value = Tokamak.P_BR()

  actual_value /= 1u"MW"

  actual_value /= Tokamak.symbol_dict["n_bar"] ^ 2
  actual_value /= Tokamak.symbol_dict["T_k"] ^ (1/2)
  actual_value /= Tokamak.symbol_dict["R_0"] ^ 3

  actual_value = SymPy.N(actual_value)

  expected_value = Tokamak.K_rad()

  @test isapprox(expected_value, actual_value)

end
