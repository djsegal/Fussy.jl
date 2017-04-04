@testset "Simplified Current Function Tests" begin

  @test isdefined(Tokamak, :simplified_current) == true

  actual_value = Tokamak.simplified_current()

  actual_value /= 1u"MA"
  actual_value /= Tokamak.symbol_dict["T_k"]

  normalization_value = Tokamak.K_CD()
  normalization_value *= Tokamak.symbol_dict["sigma_v_hat"]

  normalization_value = 1 / ( 1 - normalization_value )
  normalization_value *= Tokamak.K_I()

  actual_value = Tokamak.calc_sigma_v_hat_value(actual_value)
  normalization_value = Tokamak.calc_sigma_v_hat_value(normalization_value)

  actual_value /= normalization_value

  T_k_symbol = Tokamak.symbol_dict["T_k"]

  expected_value = 1

  for cur_T_k in [1e1, 1e2, 1e3]
    cur_value = subs(actual_value, T_k_symbol, cur_T_k)
    cur_value = SymPy.N( cur_value )

    @test isapprox(cur_value, expected_value)
  end

end
