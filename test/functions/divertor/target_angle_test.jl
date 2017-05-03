@testset "Target Angle Function Tests" begin

  @test isdefined(Tokamak, :target_angle) == true

  actual_value = Tokamak.target_angle()

  expected_value = 1.427

  @test isapprox(expected_value, actual_value, rtol=5e-3)

end
