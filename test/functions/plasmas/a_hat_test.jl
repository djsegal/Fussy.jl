@testset "A Hat Function Tests" begin

  @test isdefined(Tokamak, :a_hat) == true

  Tokamak.load_input( "R_0 = 4u\"m\"" )

  @test isapprox( Tokamak.a_hat() , 1.15u"m" , rtol=5e-4 )

end
