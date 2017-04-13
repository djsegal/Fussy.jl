@testset "P T Function Tests" begin

  @test isdefined(Tokamak, :P_T) == true

  actual_value = Tokamak.P_T()

  actual_value /= Tokamak.P_F()

  expected_value = 1.273

  @test isapprox(expected_value, actual_value, rtol=5e-4 )

end
