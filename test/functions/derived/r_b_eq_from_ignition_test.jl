@testset "R B Eq From Ignition Function Tests" begin

  @test isdefined(Tokamak, :r_b_eq_from_ignition) == true

  expected_value = Tokamak.K_PB()

  actual_value = Tokamak.r_b_eq_from_ignition()

  actual_value ^= 16 // 100

  actual_value /= Tokamak.symbol_dict["B_0"] ^ ( 15 // 100 )

  actual_value *= Tokamak.symbol_dict["T_k"] ^ ( 4 // 100 )

  actual_value *= Tokamak.symbol_dict["sigma_v_hat"] ^ ( 69 // 100 )

  cur_numerator = -Tokamak.K_BR()
  cur_numerator *= ( Tokamak.symbol_dict["T_k"] ) ^ ( 1//2 )
  cur_numerator += Tokamak.symbol_dict["sigma_v_hat"]

  cur_denominator = -Tokamak.K_CD()
  cur_denominator *= Tokamak.symbol_dict["sigma_v_hat"]
  cur_denominator += 1

  cur_denominator ^= 96 // 100

  actual_value /= cur_numerator
  actual_value *= cur_denominator

  actual_value = Tokamak.calc_sigma_v_hat_value(actual_value)

  T_k_symbol = Tokamak.symbol_dict["T_k"]

  test_count = 4

  for cur_T_k in logspace(1, test_count, test_count)
    cur_actual_value = subs(actual_value, T_k_symbol, cur_T_k)

    cur_actual_value = SymPy.N( cur_actual_value )

    @test isapprox(cur_actual_value, expected_value, rtol=2e-4)
  end

end
