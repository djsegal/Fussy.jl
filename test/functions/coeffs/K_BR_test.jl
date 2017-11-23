@testset "K BR Function Tests" begin

  @test isdefined(Fusion, :K_BR) == true

  @test isapprox( Fusion.K_BR(), 2.031e-2 , rtol=5e-4 )

end
