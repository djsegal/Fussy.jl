@testset "Calc Possible Values Function Tests" begin

  @test isdefined(Fusion, :calc_possible_values) == true

  Fusion.load_input( "nu_T = 1e-6" )
  Fusion.load_input( "nu_n = 1e-6" )

  test_count = 4

    for cur_bool in [false, true]

    if cur_bool
      test_count = Int(round( test_count / 2 ))
      Fusion.load_input("random.jl", true)
    end

    for cur_T_k in logspace(0, log10(50), test_count)

      Fusion.load_input( "T_k = $(cur_T_k)u\"keV\"" )

      actual_value = calc_possible_values()
      actual_value *= 1u"m^3/s"

      expected_value = sigma_v()
      expected_value *= 1e21

      @test isapprox(expected_value, actual_value, rtol=5e-3)

    end

  end

end
