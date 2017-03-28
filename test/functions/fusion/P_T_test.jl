@testset "P T Function Tests" begin

  @test isdefined(Tokamak, :P_T) == true

  @test Tokamak.P_T(1u"m", 1u"MA") != Nullable

  P_F = Tokamak.P_F(1u"m", 1u"MA")

  P_T = Tokamak.P_T(1u"m", 1u"MA")

  @test isapprox( P_T / P_F , 1.273 , atol=5e-3 )

end
