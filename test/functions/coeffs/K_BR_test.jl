@testset "K BR Function Tests" begin

  @test isdefined(Tokamak, :K_BR) == true

  @test isapprox( Tokamak.K_BR(), 2.031e-2 , rtol=5e-4 )

end
