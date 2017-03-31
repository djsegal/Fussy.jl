@testset "P N Function Tests" begin

  @test isdefined(Tokamak, :P_n) == true

  @test Tokamak.P_n() != Nullable

  P_F = Tokamak.P_F()

  P_n = Tokamak.P_n()

  @test isapprox( SymPy.N( P_n / P_F ) , 0.8 , rtol=5e-3 )

end
