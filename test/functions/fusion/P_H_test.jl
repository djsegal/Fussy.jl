@testset "P H Function Tests" begin

  @test isdefined(Tokamak, :P_H) == true

  @test Tokamak.P_H(1u"m", 1u"MA") != Nullable

  P_F = Tokamak.P_F(1u"m", 1u"MA")

  P_H = Tokamak.P_H(1u"m", 1u"MA")

  @test isapprox( P_H / P_F , 0.02 )

end
