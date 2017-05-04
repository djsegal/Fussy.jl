@testset "Sigma V Function Tests" begin

  @test isdefined(Tokamak, :sigma_v) == true

  @test_throws DomainError Tokamak.sigma_v()

  T_k_symbol = Tokamak.symbol_dict["T_k"]

  expected_value = 1

  test_count = 4

  for cur_bool in [false, true]

    if cur_bool
      Tokamak.load_input("test/support/input_files/random.jl", true)
    end

    for cur_T_k in logspace(0, log10(50), test_count)
      Tokamak.load_input( "T_k = $(cur_T_k)u\"keV\"" )

      actual_value = Tokamak.sigma_v()

      actual_value *= 1e21
      actual_value /= 1u"m^3/s"

      actual_value /= Tokamak.calc_possible_values()

      @test isapprox(actual_value, expected_value)
    end

  end

  Tokamak.load_input( "nu_T = 0" )
  Tokamak.load_input( "nu_n = 0" )

  actual_value = Tokamak.sigma_v()

  expected_value = Tokamak.sigma_v_ave(0.5)
  expected_value /= 2

  @test isapprox(actual_value, expected_value)

  Tokamak.load_input( "nu_T = 1e-6" )
  Tokamak.load_input( "nu_n = 1e-6" )

  T_list = linspace(1, 100, 100)

  n_points = 501

  for cur_bool in [false, true]

    if cur_bool
      Tokamak.load_input("test/support/input_files/random.jl", true)
    end

    sigma_v_expected = []
    sigma_v_actual = []

    for cur_T_k in logspace(0, log10(50), test_count)

      Tokamak.load_input( "T_k = $(cur_T_k)u\"keV\"" )

      cur_integral = []

      for i in 1:n_points
        r = ( i - 1 ) / ( n_points - 1 )
        dr = 1 / ( n_points - 1 )

        sigma_v_ave = Tokamak.sigma_v_ave(r)

        push!(cur_integral, (1+Tokamak.nu_n)^2 * (1-r^2)^(2*Tokamak.nu_n) * sigma_v_ave * r * dr)
      end

      cur_sum = 0u"m^3/s"

      for l in 2:n_points-1
        cur_sum += cur_integral[l]
      end

      push!(sigma_v_expected, cur_sum)
      push!(sigma_v_actual, Tokamak.sigma_v())

    end

    relative_error = 1

    for i in 1:length(sigma_v_expected)
      cur_error = sigma_v_expected[i]
      cur_error -= sigma_v_actual[i]
      cur_error /= min(sigma_v_expected[i], sigma_v_actual[i])

      cur_error = abs(cur_error)

      if cur_error > relative_error
        continue
      end

      relative_error = cur_error
    end

    @test relative_error < 5e-3

  end

end
