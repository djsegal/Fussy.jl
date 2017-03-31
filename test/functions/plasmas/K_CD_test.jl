@testset "K CD Function Tests" begin

  @test isdefined(Tokamak, :K_CD) == true

  @test isapprox( Tokamak.K_CD(), 0.2192, rtol=5e-4 )

end
