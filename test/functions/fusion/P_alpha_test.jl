@testset "P Alpha Function Tests" begin

  @test isdefined(Tokamak, :P_alpha) == true

  @test Tokamak.P_alpha() != Nullable

  P_F = Tokamak.P_F()

  P_alpha = Tokamak.P_alpha()

  @test isapprox( SymPy.N( P_alpha / P_F ) , 0.2 , rtol=1e-2 )

end
