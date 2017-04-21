@testset "Simplified Current Function Tests" begin

  @test isdefined(Tokamak, :simplified_current) == true

  actual_value = Tokamak.simplified_current()

  actual_value /= 1u"MA"

  actual_value /= Tokamak.symbol_dict["T_k"]

  actual_value /= Tokamak.K_I()

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
