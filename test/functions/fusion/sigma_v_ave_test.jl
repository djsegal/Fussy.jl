@testset "Sigma V Ave Function Tests" begin

  @test isdefined(Fusion, :sigma_v_ave) == true

  test_count = 5

  log_T_initial = log10(5)
  log_T_final = log10(25)

  cur_small_value = 5e-23

  for cur_bool in [false, true]

    if cur_bool
      Fusion.load_input("random.jl", true)
    else
      Fusion.load_input("defaults.jl", true)
      Fusion.load_input("test/input.jl", true)
    end

    for cur_T_k in logspace(log_T_initial, log_T_final, test_count)

      for cur_rho in linspace(0.25, 0.75, test_count)
        Fusion.load_input( "T_k = $(cur_T_k)u\"keV\"" )

        Fusion.load_input( "use_slow_sigma_v_funcs = true" )
        expected_value = Fusion.sigma_v_ave(cur_rho)
        expected_value /= 1u"m^3/s"

        Fusion.load_input( "use_slow_sigma_v_funcs = false" )
        actual_value = Fusion.sigma_v_ave(cur_rho)
        actual_value /= 1u"m^3/s"

        if cur_rho == Fusion.integral_one
          @test actual_value < cur_small_value
          @test expected_value < cur_small_value
        elseif expected_value == 0
          @test abs(actual_value) < cur_small_value
        elseif actual_value == 0
          @test abs(expected_value) < cur_small_value
        else
          @test isapprox(expected_value, actual_value, rtol=0.95)
        end
      end

    end

  end

  Fusion.load_input( "nu_T = 0" )
  Fusion.load_input( "use_slow_sigma_v_funcs = true" )

  moses_table = Dict(
    " T_k =   1u\"keV\"" => 6.86e-21,
    " T_k =   2u\"keV\"" => 2.98e-19,
    " T_k =   5u\"keV\"" => 1.37e-17,
    " T_k =  10u\"keV\"" => 1.14e-16,
    " T_k =  20u\"keV\"" => 4.33e-16,
    " T_k =  50u\"keV\"" => 8.65e-16,
    " T_k = 100u\"keV\"" => 8.45e-16,
  )

  for (key, value) in moses_table
    Fusion.load_input( key )

    expected_value = Fusion.sigma_v_ave(0.5)/1u"m^3*s^-1"
    actual_value = value * ( 1u"(cm/m)^3" |> NoUnits )

    @test isapprox( expected_value , actual_value , rtol=3.0u"keV"/Fusion.T_k )
  end

end
