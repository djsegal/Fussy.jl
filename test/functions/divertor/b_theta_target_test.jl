@testset "B Theta Target Function Tests" begin

  @test isdefined(Tokamak, :b_theta_target) == true

  actual_value = Tokamak.b_theta_target()

  expected_value = 0.0446

  @test isapprox(expected_value, actual_value, rtol=5e-3)

end
