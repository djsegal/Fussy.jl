@testset "Sigma V Function Tests" begin

  @test isdefined(Tokamak, :sigma_v) == true

  @test Tokamak.sigma_v() != Nullable

  actual_value = Tokamak.sigma_v()
  actual_value *= 10^21

  actual_value /= Tokamak.calculate_sigma_v_hat()

  expected_value = 1

  T_k_symbol = Tokamak.symbol_dict["T_k"]

  for cur_T_k in [1e1, 1e2, 1e3]
    cur_value = subs(actual_value, T_k_symbol, cur_T_k)
    cur_value = SymPy.N( cur_value )

    @test isapprox(cur_value, expected_value)
  end

end
