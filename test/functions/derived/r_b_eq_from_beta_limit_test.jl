@testset "R B Eq From Beta Limit Function Tests" begin

  @test isdefined(Tokamak, :r_b_eq_from_beta_limit) == true

  Tokamak.load_input( "beta_N = $(Tokamak.max_beta_N)" )

  expected_value = Tokamak.K_beta()

  actual_value = Tokamak.r_b_eq_from_beta_limit()

  actual_value += Tokamak.symbol_dict["R_0"]

  actual_value *= Tokamak.symbol_dict["B_0"]

  actual_value /= Tokamak.symbol_dict["T_k"]

  @test isapprox(expected_value, actual_value, rtol=5e-4)

end
