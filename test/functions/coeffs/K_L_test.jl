@testset "K L Function Tests" begin

  @test isdefined(Tokamak, :K_L) == true

  @test isapprox( Tokamak.K_L(), 1.773e-2 , rtol=5e-4 )

end
