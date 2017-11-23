@testset "A Hat Function Tests" begin

  @test isdefined(Fusion, :a_hat) == true

  Fusion.load_input( "R_0 = 4u\"m\"" )

  @test isapprox( a_hat() , 1.15u"m" , rtol=5e-4 )

end
