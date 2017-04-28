@testset "R B Eq From Wall Loading Function Tests" begin

  @test isdefined(Tokamak, :r_b_eq_from_wall_loading) == true

  Tokamak.load_input( "P_W = $( Tokamak.max_P_W / ( 1u"MW" / 1u"m^2" ) ) * ( 1u\"MW\" / 1u\"m^2\" )" )

  expected_value = Tokamak.K_W()

  actual_value = Tokamak.r_b_eq_from_wall_loading()

  actual_value += Tokamak.symbol_dict["R_0"]

  actual_value ^= 3

  actual_value /= Tokamak.symbol_dict["sigma_v_hat"]
  actual_value /= Tokamak.symbol_dict["T_k"] ^ 2

  actual_value *= Tokamak.symbol_dict["K_CD_denom"] ^ 2

  @test isapprox(expected_value, actual_value, rtol=5e-3)

end
