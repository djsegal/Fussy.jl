@testset "K H Function Tests" begin

  @test isdefined(Tokamak, :K_H) == true

  @test isapprox( Tokamak.K_H() , 0.01031 , rtol=5e-4 )

end
