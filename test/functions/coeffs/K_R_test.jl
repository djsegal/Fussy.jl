@testset "K R Function Tests" begin

  @test isdefined(Tokamak, :K_R) == true

  @test isapprox( Tokamak.K_R(), 2.948e-3 , rtol=5e-4 )

end
