# skip: true

@testset "Heat Load Limit Function Tests" begin

  @test isdefined(Tokamak, :heat_load_limit) == true

  @test Tokamak.heat_load_limit() != Nullable

  expected_value = Tokamak.K_DV()

  actual_value = Tokamak.heat_load_limit()

  actual_value += Tokamak.h_parallel

  actual_value *= 1u"m^2"
  actual_value /= 1u"MW"

  actual_value = collect(actual_value, Tokamak.symbol_dict["R_0"] )

  actual_value *= Tokamak.symbol_dict["R_0"] ^ ( 16 // 5 )

  right_term = Tokamak.symbol_dict["T_k"]
  right_term /= Tokamak.symbol_dict["K_CD_denom"]

  right_term ^= ( 16 // 5 )

  actual_value /= right_term

  left_term = -Tokamak.K_BR()
  left_term *= sqrt( Tokamak.T_k / 1u"keV" )
  left_term += ( Tokamak.sigma_v_hat / 1u"m^3/s" )

  actual_value /= left_term

  test_count = 4

  for cur_bool in [false, true]

    if cur_bool
      test_count = Int(round( test_count / 2 ))
      Tokamak.load_input("random.jl", true)
    end

    for cur_T_k in logspace(log10(5), log10(50), test_count)
      Tokamak.load_input( "T_k = $(cur_T_k)u\"keV\"" )

      cur_actual_value = Tokamak.calc_possible_values(actual_value)

      @test isapprox(expected_value, cur_actual_value, rtol=1e-2)
    end

  end

end
