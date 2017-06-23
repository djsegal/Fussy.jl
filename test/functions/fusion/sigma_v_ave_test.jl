@testset "Sigma V Ave Function Tests" begin

  @test isdefined(Tokamak, :sigma_v_ave) == true

  # using nrl table for data (p. 45)

  nrl_table = Dict(
    "T_k = 5u\"keV\"" => 1.3e-17,
    "T_k = 10u\"keV\"" => 1.1e-16,
    "T_k = 20u\"keV\"" => 4.2e-16,
  )

  test_count = 4

  for cur_bool in [false, true]

    if cur_bool
      Tokamak.load_input("random.jl", true)
    else
      Tokamak.load_input("defaults.jl", true)
      Tokamak.load_input("test/input.jl", true)
    end

    for cur_T_k in logspace(log10(5), log10(20), test_count)

      for cur_rho in linspace(0, 1, test_count)
        Tokamak.load_input( "T_k = $(cur_T_k)u\"keV\"" )

        Tokamak.load_input( "use_lin_sigma_v_funcs = false" )
        expected_value = Tokamak.sigma_v_ave(cur_rho)
        expected_value /= 1u"m^3/s"

        Tokamak.load_input( "use_lin_sigma_v_funcs = true" )
        actual_value = Tokamak.sigma_v_ave(cur_rho)
        actual_value /= 1u"m^3/s"

        if expected_value == 0
          @test actual_value < 5e-24
        else
          @test isapprox(expected_value, actual_value, rtol=0.95)
        end
      end

    end

  end

  Tokamak.load_input( "nu_T = 0" )

  for (key, value) in nrl_table
    Tokamak.load_input( key )
    expected_value = Tokamak.sigma_v_ave(0.5)/1u"m^3*s^-1"
    actual_value = value * ( 1u"(cm/m)^3" |> NoUnits )

    @test isapprox( expected_value , actual_value , rtol=5e-1 )
  end

end
