@testset "R B Eq From Heat Loading Function Tests" begin

  @test isdefined(Tokamak, :r_b_eq_from_heat_loading) == true

  expected_value = Tokamak.K_DV()

  actual_value = Tokamak.r_b_eq_from_heat_loading()

  actual_value += Tokamak.symbol_dict["R_0"]

  actual_value ^= 2

  actual_value /= Tokamak.symbol_dict["B_0"]

  actual_value /= Tokamak.symbol_dict["T_k"] ^ 2

  actual_value *= Tokamak.symbol_dict["K_CD_denom"] ^ 2

  cur_numerator = -Tokamak.K_BR()
  cur_numerator *= sqrt(Tokamak.symbol_dict["T_k"])
  cur_numerator += Tokamak.symbol_dict["sigma_v_hat"]

  actual_value /= cur_numerator

  test_count = 4

  for cur_T_k in logspace(0, log10(50), test_count)
    Tokamak.load_input( "T_k = $(cur_T_k)u\"keV\"" )

    cur_actual_value = Tokamak.calc_possible_values(actual_value)

    @test isapprox(cur_actual_value, expected_value, rtol=5e-2)
  end

end
