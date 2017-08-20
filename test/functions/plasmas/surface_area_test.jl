@testset "Surface Area Function Tests" begin

  @test isdefined(Tokamak, :surface_area) == true

  Tokamak.load_input("arc.jl", true)

  Tokamak.load_input(" R_0 = 3.3 * 1u\"m\" ")

  actual_value = Tokamak.surface_area()

  actual_value /= 1u"m^2"

  expected_value = 215.2997982

  @test isapprox(expected_value, actual_value, rtol=1e-1)

end
