@testset "Simplified Current Function Tests" begin

  @test isdefined(Tokamak, :simplified_current) == true

  actual_value = Tokamak.simplified_current()

  actual_value /= 1u"MA"

  actual_value /= Tokamak.symbol_dict["T_k"]

  actual_value /= Tokamak.K_I()

  expected_value = Tokamak.K_CD()
  expected_value *= Tokamak.symbol_dict["sigma_v_hat"]

  expected_value = 1 / ( 1 - expected_value )

  actual_value = Tokamak.calc_sigma_v_hat_value(actual_value)
  expected_value = Tokamak.calc_sigma_v_hat_value(expected_value)

  T_k_symbol = Tokamak.symbol_dict["T_k"]

  test_count = 4

  for cur_T_k in logspace(1, test_count, test_count)
    cur_expected_value = subs(expected_value, T_k_symbol, cur_T_k)
    cur_actual_value = subs(actual_value, T_k_symbol, cur_T_k)

    cur_expected_value = SymPy.N( cur_expected_value )
    cur_actual_value = SymPy.N( cur_actual_value )

    @test isapprox(cur_actual_value, cur_expected_value, rtol=1e-4)
  end

end
