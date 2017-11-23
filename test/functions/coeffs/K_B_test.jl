@testset "K B Function Tests" begin

  @test isdefined(Fusion, :K_B) == true

  @test isapprox( Fusion.K_B() , 0.07279 , rtol=1e-4 )

end
