@testset "Geometry Scaling Function Tests" begin

  @test isdefined(Tokamak, :geometry_scaling) == true

  actual_value = Tokamak.geometry_scaling()

  expected_value = 0.9719

  @test isapprox(expected_value, actual_value, rtol=5e-4)

end
