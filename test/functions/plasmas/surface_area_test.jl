@testset "Surface Area Function Tests" begin

  @test isdefined(Fusion, :surface_area) == true

  Fusion.load_input("arc.jl", true)

  Fusion.load_input(" R_0 = 3.3 * 1u\"m\" ")

  actual_value = surface_area()

  actual_value /= 1u"m^2"

  expected_value = 215.2997982

  @test isapprox(expected_value, actual_value, rtol=1e-1)

end
