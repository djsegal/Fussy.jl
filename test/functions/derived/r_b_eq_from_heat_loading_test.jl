# skip: true

@testset "R B Eq From Heat Loading Function Tests" begin

  @test isdefined(Tokamak, :r_b_eq_from_heat_loading) == true

  Tokamak.load_input( "h_parallel = $( Tokamak.max_h_parallel / ( 1u"MW" / 1u"m^2" ) ) * ( 1u\"MW\" / 1u\"m^2\" )" )

  expected_value = Tokamak.K_DV()

  actual_value = Tokamak.r_b_eq_from_heat_loading()

  actual_value += Tokamak.symbol_dict["R_0"]

  actual_value /= Tokamak.symbol_dict["T_k"]

  actual_value *= Tokamak.symbol_dict["K_CD_denom"]

  actual_value ^= ( 32 // 10 )

  actual_value *= Tokamak.h_parallel

  cur_block = -Tokamak.K_nu()
  cur_block *= sqrt(Tokamak.symbol_dict["T_k"])
  cur_block += Tokamak.symbol_dict["sigma_v_hat"]

  actual_value /= cur_block

  actual_value *= 1u"m^2"

  actual_value /= 1u"MW"

  test_count = 4

  for cur_bool in [false, true]

    if cur_bool
      test_count = Int(round( test_count / 2 ))
      Tokamak.load_input("random.jl", true)
    end

    for cur_T_k in logspace(0, log10(50), test_count)
      Tokamak.load_input( "T_k = $(cur_T_k)u\"keV\"" )

      cur_actual_value = Tokamak.calc_possible_values(actual_value)

      @test isapprox(cur_actual_value, expected_value, rtol=5e-2)
    end

  end

end
