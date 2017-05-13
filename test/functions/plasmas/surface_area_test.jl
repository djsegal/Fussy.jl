@testset "Surface Area Function Tests" begin

  @test isdefined(Tokamak, :surface_area) == true

  actual_value = Tokamak.surface_area()

  actual_value /= 1u"m^2"

  actual_value /= Tokamak.symbol_dict["R_0"] ^ 2

  expected_value = .3435

  @test isapprox(expected_value, actual_value, rtol=5e-4)

end
