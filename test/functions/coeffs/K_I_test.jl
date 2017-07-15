@testset "K I Function Tests" begin

  @test isdefined(Tokamak, :K_I) == true

  @test isapprox( Tokamak.K_I(), 0.2966, rtol=5e-4 )

end
