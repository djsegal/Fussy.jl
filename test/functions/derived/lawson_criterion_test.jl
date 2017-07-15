@testset "Lawson Criterion Function Tests" begin

  @test isdefined(Tokamak, :lawson_criterion) == true

  actual_value = Tokamak.lawson_criterion()

  actual_value /= 1u"s"
  actual_value /= 1u"n20"

  actual_value /= Tokamak.symbol_dict["T_k"]

  actual_value /= Tokamak.K_L()

  expected_value = -Tokamak.K_nu()
  expected_value *= Tokamak.symbol_dict["T_k"] ^ (1/2)

  expected_value += Tokamak.symbol_dict["sigma_v_hat"]
  expected_value = 1 / expected_value

  test_count = 4

  for cur_bool in [false, true]

    if cur_bool
      test_count = Int(round( test_count / 2 ))
      Tokamak.load_input("random.jl", true)
    end

    for cur_T_k in logspace(0, log10(50), test_count)
      Tokamak.load_input( "T_k = $(cur_T_k)u\"keV\"" )

      cur_actual_value = Tokamak.calc_possible_values(actual_value)
      cur_expected_value = Tokamak.calc_possible_values(expected_value)

      @test isapprox(cur_actual_value, cur_expected_value, rtol=5e-2)
    end

  end

end
