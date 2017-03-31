@testset "P T Function Tests" begin

  @test isdefined(Tokamak, :P_T) == true

  @test Tokamak.P_T() != Nullable

  P_F = Tokamak.P_F()

  P_T = Tokamak.P_T()

  @test isapprox( SymPy.N( P_T / P_F ) , 1.273 , atol=5e-3 )

end
