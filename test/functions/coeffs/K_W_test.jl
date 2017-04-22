@testset "K W Function Tests" begin

  @test isdefined(Tokamak, :K_W) == true

  @test isapprox( Tokamak.K_W() , 0.7764 , rtol=5e-4 )

end
