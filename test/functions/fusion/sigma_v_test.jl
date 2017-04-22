@testset "Sigma V Function Tests" begin

  @test isdefined(Tokamak, :sigma_v) == true

  @test_throws DomainError Tokamak.sigma_v()

  T_k_symbol = Tokamak.symbol_dict["T_k"]

  expected_value = 1

  test_count = 4

  for cur_T_k in logspace(0, log10(50), test_count)
    Tokamak.load_input( "T_k = $(cur_T_k)u\"keV\"" )

    actual_value = Tokamak.sigma_v()

    actual_value *= 10^21
    actual_value /= 1u"m^3/s"

    actual_value /= Tokamak.calc_possible_values()

    @test isapprox(actual_value, expected_value)
  end

  Tokamak.load_input( "nu_T = 0" )
  Tokamak.load_input( "nu_n = 0" )

  actual_value = Tokamak.sigma_v()

  expected_value = Tokamak.sigma_v_ave(0.5)
  expected_value /= 2

  @test isapprox(actual_value, expected_value)

end
