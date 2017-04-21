@testset "Sigma V Ave Function Tests" begin

  @test isdefined(Tokamak, :sigma_v_ave) == true

  # using nrl table for data (p. 45)

  nrl_table = Dict(
    "T_k = 5u\"keV\"" => 1.3e-17,
    "T_k = 10u\"keV\"" => 1.1e-16,
    "T_k = 20u\"keV\"" => 4.2e-16,
  )

  Tokamak.load_input( "nu_T = 0" )

  for (key, value) in nrl_table
    Tokamak.load_input( key )
    expected_value = Tokamak.sigma_v_ave(0.5)/1u"m^3*s^-1"
    actual_value = value * ( 1u"(cm/m)^3" |> NoUnits )

    @test isapprox( expected_value , actual_value , rtol=5e-1 )
  end

end
