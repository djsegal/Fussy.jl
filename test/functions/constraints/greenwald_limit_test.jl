@testset "Greenwald Limit Function Tests" begin

  @test isdefined(Tokamak, :greenwald_limit) == true

  actual_value = Tokamak.greenwald_limit()

  actual_value += ( Tokamak.n_bar / 1u"n20" )

  actual_value /= Tokamak.symbol_dict["I_M"]
  actual_value *= Tokamak.symbol_dict["R_0"] ^ 2

  expected_value = Tokamak.K_N_G()

  @test isapprox(expected_value, actual_value, rtol=5e-3)

end
