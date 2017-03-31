@testset "P Alpha Function Tests" begin

  @test isdefined(Tokamak, :P_alpha) == true

  @test Tokamak.P_alpha(1u"MA") != Nullable

  P_F = Tokamak.P_F(1u"MA")

  P_alpha = Tokamak.P_alpha(1u"MA")

  @test isapprox( SymPy.N( P_alpha / P_F ) , 0.2 , atol=5e-3 )

end
