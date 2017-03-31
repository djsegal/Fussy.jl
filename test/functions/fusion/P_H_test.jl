@testset "P H Function Tests" begin

  @test isdefined(Tokamak, :P_H) == true

  @test Tokamak.P_H() != Nullable

  P_F = Tokamak.P_F()

  P_H = Tokamak.P_H()

  @test isapprox( SymPy.N( P_H / P_F ) , 0.02 )

end
