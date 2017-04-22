@testset "R B Eq From Ignition Function Tests" begin

  @test isdefined(Tokamak, :r_b_eq_from_ignition) == true

  expected_value = Tokamak.K_PB()

  actual_value = Tokamak.r_b_eq_from_ignition()

  actual_value += Tokamak.symbol_dict["R_0"]

  actual_value ^= 16 // 100

  actual_value *= Tokamak.symbol_dict["K_CD_denom"] ^ ( 96 // 100 )

  actual_value *= Tokamak.symbol_dict["sigma_v_hat"] ^ ( 69 // 100 )

  actual_value = collect(actual_value, Tokamak.symbol_dict["B_0"] )

  actual_value /= Tokamak.symbol_dict["B_0"] ^ ( 15 // 100 )

  actual_value *= Tokamak.symbol_dict["T_k"] ^ ( 4 // 100 )

  cur_numerator = -Tokamak.K_BR()
  cur_numerator *= ( Tokamak.symbol_dict["T_k"] ) ^ ( 1//2 )
  cur_numerator += Tokamak.symbol_dict["sigma_v_hat"]

  actual_value /= cur_numerator

  test_count = 4

  for cur_T_k in logspace(1, 4, test_count)
    Tokamak.load_input( "T_k = $(cur_T_k)u\"keV\"" )

    cur_actual_value = Tokamak.calc_sigma_v_hat_value(actual_value)

    @test isapprox(cur_actual_value, expected_value, rtol=5e-4)
  end

end
