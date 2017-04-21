@testset "Simplified N Bar Tau E Function Tests" begin

  @test isdefined(Tokamak, :simplified_n_bar_tau_E) == true

  actual_value = Tokamak.simplified_n_bar_tau_E()

  actual_value /= 1u"s"
  actual_value /= 1u"n20"

  actual_value /= Tokamak.K_H()

  actual_value /= Tokamak.symbol_dict["B_0"] ^ ( 15 // 100 )
  actual_value *= Tokamak.symbol_dict["R_0"] ^ ( 16 // 100 )

  actual_value /= Tokamak.symbol_dict["T_k"] ^ ( 96 // 100 )

  actual_value *= Tokamak.symbol_dict["sigma_v_hat"] ^ ( 69 // 100 )

  expected_value = -Tokamak.K_CD()
  expected_value *= Tokamak.symbol_dict["sigma_v_hat"]

  expected_value += 1
  expected_value ^= 96 // 100

  expected_value = 1 / expected_value

  T_k_symbol = Tokamak.symbol_dict["T_k"]

  test_count = 4

  for cur_T_k in logspace(0, log10(50), test_count)
    Tokamak.load_input( "T_k = $(cur_T_k)u\"keV\"" )

    cur_actual_value = Tokamak.calc_sigma_v_hat_value(actual_value)
    cur_expected_value = Tokamak.calc_sigma_v_hat_value(expected_value)

    @test isapprox(cur_actual_value, cur_expected_value, rtol=5e-3)
  end

end
