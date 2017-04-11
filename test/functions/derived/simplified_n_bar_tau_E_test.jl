@testset "Simplified N Bar Tau E Function Tests" begin

  @test isdefined(Tokamak, :simplified_n_bar_tau_E) == true

  @test Tokamak.simplified_n_bar_tau_E() != Nullable

  actual_value = Tokamak.simplified_n_bar_tau_E()
  actual_value /= 1u"n20" * 1u"s"

  actual_value *= Tokamak.symbol_dict["sigma_v_hat"] ^ ( 69 // 100 )
  actual_value *= Tokamak.symbol_dict["R_0"] ^ ( 16 // 100 )

  actual_value /= Tokamak.symbol_dict["B_0"] ^ ( 15 // 100 )
  actual_value /= Tokamak.symbol_dict["T_k"] ^ ( 96 // 100 )

  actual_value /= Tokamak.K_H()

  actual_value = Tokamak.calc_sigma_v_hat_value(actual_value)

  expected_value = Tokamak.K_CD()
  expected_value *= Tokamak.symbol_dict["sigma_v_hat"]

  expected_value = ( 1 - expected_value ) ^ -0.96

  expected_value = Tokamak.calc_sigma_v_hat_value(expected_value)

  println("WOO")
  T_k_symbol = Tokamak.symbol_dict["T_k"]

  for cur_T_k in [1e1, 1e2, 1e3]
    cur_expected_value = subs(expected_value, T_k_symbol, cur_T_k)
    cur_actual_value = subs(actual_value, T_k_symbol, cur_T_k)

    cur_expected_value = SymPy.N( cur_expected_value )
    cur_actual_value = SymPy.N( cur_actual_value )

    # cur_value = subs(actual_value, T_k_symbol, cur_T_k)

    println(cur_expected_value)
    println(cur_actual_value)

    # @test isapprox(cur_value, expected_value)
  end

end
