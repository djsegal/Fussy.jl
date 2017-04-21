@testset "Simplified Density Function Tests" begin

  @test isdefined(Tokamak, :simplified_density) == true

  actual_value = Tokamak.simplified_density()

  actual_value /= 1u"n20"

  actual_value /= Tokamak.symbol_dict["T_k"]
  actual_value *= Tokamak.symbol_dict["R_0"] ^ 2

  actual_value /= Tokamak.K_n()

  expected_value = Tokamak.K_CD()
  expected_value *= Tokamak.symbol_dict["sigma_v_hat"]

  expected_value = 1 / ( 1 - expected_value )

  T_k_symbol = Tokamak.symbol_dict["T_k"]

  test_count = 4

  for cur_T_k in logspace(0, log10(50), test_count)
    Tokamak.load_input( "T_k = $(cur_T_k)u\"keV\"" )

    cur_actual_value = Tokamak.calc_sigma_v_hat_value(actual_value)
    cur_expected_value = Tokamak.calc_sigma_v_hat_value(expected_value)

    @test isapprox(cur_actual_value, cur_expected_value, rtol=1e-4)
  end

end
