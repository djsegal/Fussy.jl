@testset "P N Function Tests" begin

  @test isdefined(Tokamak, :P_n) == true

  @test Tokamak.P_n(1u"MA") != Nullable

  P_F = Tokamak.P_F(1u"MA")

  P_n = Tokamak.P_n(1u"MA")

  @test isapprox( SymPy.N( P_n / P_F ) , 0.8 , atol=5e-3 )

end
