@testset "Troyon Beta Limit Function Tests" begin

  @test isdefined(Tokamak, :troyon_beta_limit) == true

  Tokamak.load_input( "beta_N = $(Tokamak.max_beta_N)" )

  @test Tokamak.troyon_beta_limit() != Nullable

  cur_beta_limit = Tokamak.troyon_beta_limit()

  cur_n_bar = Tokamak.symbol_dict["n_bar"]

  expected_value = 12.42

  actual_value = SymPy.solve(cur_beta_limit, cur_n_bar)[1]
  actual_value *= Tokamak.symbol_dict["T_k"]

  actual_value *= Tokamak.symbol_dict["R_0"]
  actual_value /= Tokamak.symbol_dict["I_M"]
  actual_value /= Tokamak.symbol_dict["B_0"]

  actual_value *= 1 + Tokamak.nu_n
  actual_value *= 1 + Tokamak.nu_T
  actual_value /= 1 + Tokamak.nu_n + Tokamak.nu_T

  actual_value *= Tokamak.epsilon
  actual_value /= Tokamak.beta_N

  @test isapprox(expected_value, actual_value, rtol=5e-4)

end
