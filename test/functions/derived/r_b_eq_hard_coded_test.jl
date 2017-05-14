# skip: true

@testset "R B Eq Hard Coded Function Tests" begin

  @test isdefined(Tokamak, :r_b_eq_hard_coded) == true

  actual_value = Tokamak.r_b_eq_hard_coded()

  actual_value += Tokamak.symbol_dict["R_0"] ^ ( 16 // 100 )

  actual_value *= Tokamak.symbol_dict["K_CD_denom"] ^ ( 96 // 100 )

  actual_value *= Tokamak.symbol_dict["sigma_v_hat"] ^ ( 69 // 100 )

  actual_value *= Tokamak.symbol_dict["T_k"] ^ ( 4 // 100 )

  actual_value /= Tokamak.symbol_dict["B_0"] ^ ( 15 // 100 )

  expected_value = Tokamak.r_b_eq_from_ignition()

  expected_value += Tokamak.symbol_dict["R_0"]

  expected_value ^= 16 // 100

  expected_value *= Tokamak.symbol_dict["K_CD_denom"] ^ ( 96 // 100 )

  expected_value *= Tokamak.symbol_dict["sigma_v_hat"] ^ ( 69 // 100 )

  expected_value *= Tokamak.symbol_dict["T_k"] ^ ( 4 // 100 )

  expected_value = collect(expected_value, Tokamak.symbol_dict["B_0"] )

  expected_value /= Tokamak.symbol_dict["B_0"] ^ ( 15 // 100 )

  test_count = 7

  for cur_bool in [false, true]

    if cur_bool
      test_count = Int(round( test_count / 2 ))
      Tokamak.load_input("random.jl", true)
    end

    num_bad_answers = 0

    for cur_T_k in linspace(0, 50, test_count)
      Tokamak.load_input( "T_k = $(cur_T_k)u\"keV\"" )

      cur_actual_value = Tokamak.calc_possible_values(actual_value)

      if cur_actual_value < 0
        num_bad_answers += 1
        continue
      end

      cur_expected_value = abs(Tokamak.calc_possible_values(expected_value))

      @test isapprox(cur_actual_value, cur_expected_value, rtol=5e-2)
    end

    @test num_bad_answers < 3

  end

end
