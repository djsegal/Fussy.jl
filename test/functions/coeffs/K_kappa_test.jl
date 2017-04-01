@testset "K Kappa Function Tests" begin

  @test isdefined(Tokamak, :K_kappa) == true

  @test isapprox( Tokamak.K_kappa() , 0.1221 , rtol=1e-4 )

end
