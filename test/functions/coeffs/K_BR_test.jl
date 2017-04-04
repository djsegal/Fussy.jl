@testset "K BR Function Tests" begin

  @test isdefined(Tokamak, :K_BR) == true

  @test isapprox( Tokamak.K_BR(), 2.948e-3 , rtol=5e-4 )

end
