@testset "K B Function Tests" begin

  @test isdefined(Tokamak, :K_B) == true

  @test isapprox( Tokamak.K_B() , 0.07279 , rtol=1e-4 )

end
