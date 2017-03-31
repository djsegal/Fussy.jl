@testset "A Bar Function Tests" begin

  @test isdefined(Tokamak, :a_bar) == true

  Tokamak.load_input( "R_0 = 4u\"m\"" )

  @test isapprox( Tokamak.a_bar() , 1.342u"m" , atol=5e-3u"m" )

end
