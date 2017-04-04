@testset "K CD Hat Function Tests" begin

  @test isdefined(Tokamak, :K_CD_hat) == true

  @test isapprox( Tokamak.K_CD_hat(), 0.2192, rtol=5e-4 )

end
