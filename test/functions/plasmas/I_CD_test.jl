@testset "I CD Function Tests" begin

  @test isdefined(Tokamak, :I_CD) == true

  actual_value = Tokamak.I_CD()

  actual_value /= 1u"MA"

  actual_value /= ( Tokamak.P_F() / 1u"MW" )

  actual_value *= Tokamak.Q

  actual_value *= Tokamak.symbol_dict["n_bar"]
  actual_value *= Tokamak.symbol_dict["R_0"]

  expected_value = Tokamak.eta_CD

  @test isapprox(expected_value, actual_value, rtol=5e-4 )

end
