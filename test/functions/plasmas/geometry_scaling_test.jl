@testset "Geometry Scaling Function Tests" begin

  @test isdefined(Fusion, :geometry_scaling) == true

  Fusion.load_input(" enable_geom_scaling = true ")

  actual_value = geometry_scaling()

  expected_value = 0.9719

  @test isapprox(expected_value, actual_value, rtol=5e-4)

  cur_tests = Dict(
    0.40 => 0.994,
    0.00 => 1.088,
    1.00 => 0.875
  )

  for (cur_key, expected_value) in cur_tests

    actual_value = geometry_scaling(cur_key)

    @test isapprox(expected_value, actual_value, rtol=1e-3)

  end

end
