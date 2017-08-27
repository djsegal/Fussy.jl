@testset "Volume Function Tests" begin

  @test isdefined(Tokamak, :volume) == true

  Tokamak.load_input(" enable_geom_scaling = true ")

  actual_value = Tokamak.volume()

  actual_value /= 1u"m^3"

  actual_value /= Tokamak.symbol_dict["R_0"] ^ 3

  expected_value = 2.158

  @test isapprox(expected_value, actual_value, rtol=5e-4)

end
