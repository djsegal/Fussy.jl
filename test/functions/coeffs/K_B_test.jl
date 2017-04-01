@testset "K B Function Tests" begin

  @test isdefined(Tokamak, :K_B) == true

  @test isapprox( Tokamak.K_B() , 0.07181 , rtol=5e-4 )

end
