@testset "K I Function Tests" begin

  @test isdefined(Fusion, :K_I) == true

  @test isapprox( Fusion.K_I(), 0.2966, rtol=5e-4 )

end
