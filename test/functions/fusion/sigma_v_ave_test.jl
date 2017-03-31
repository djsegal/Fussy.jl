@testset "Sigma V Ave Function Tests" begin

  @test isdefined(Tokamak, :sigma_v_ave) == true

  # using nrl table for data (p. 45)

  nrl_table = Dict(
    "T_k = 1e0u\"keV\"" => 5.5e-21,
    "T_k = 1e1u\"keV\"" => 1.1e-16,
    "T_k = 1e2u\"keV\"" => 8.5e-16,
  )

  for (key, value) in nrl_table
    Tokamak.load_input( key )
    expected_value = Tokamak.sigma_v_ave()/1u"m^3*s^-1"
    actual_value = value * ( 1u"(cm/m)^3" |> NoUnits )

    tolerance = log(10, min(actual_value, expected_value))
    tolerance = 5 * 10 ^ tolerance

    @test isapprox(expected_value, actual_value, atol=tolerance)
  end

end
