@testset "Lawson Criterion Function Tests" begin

  @test isdefined(Tokamak, :lawson_criterion) == true

  actual_value = Tokamak.lawson_criterion()

  actual_value /= 1u"s"
  actual_value /= 1u"n20"

  actual_value /= Tokamak.symbol_dict["T_k"]

  actual_value /= Tokamak.K_L()

  expected_value = -Tokamak.K_BR()
  expected_value *= Tokamak.symbol_dict["T_k"] ^ (1/2)

  expected_value += Tokamak.symbol_dict["sigma_v_hat"]
  expected_value = 1 / expected_value

  actual_value = Tokamak.calc_sigma_v_hat_value(actual_value)
  expected_value = Tokamak.calc_sigma_v_hat_value(expected_value)

  T_k_symbol = Tokamak.symbol_dict["T_k"]

  test_count = 4

  for cur_T_k in logspace(1, test_count, test_count)
    cur_expected_value = subs(expected_value, T_k_symbol, cur_T_k)
    cur_actual_value = subs(actual_value, T_k_symbol, cur_T_k)

    cur_expected_value = SymPy.N( cur_expected_value )
    cur_actual_value = SymPy.N( cur_actual_value )

    @test isapprox(cur_actual_value, cur_expected_value, rtol=5e-3)
  end

end
