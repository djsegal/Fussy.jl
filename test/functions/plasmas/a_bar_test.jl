@testset "A Bar Function Tests" begin

  @test isdefined(Fusion, :a_bar) == true

  Fusion.load_input( "R_0 = 4u\"m\"" )

  @test isapprox( a_bar() , 1.342u"m" , rtol=5e-4 )

end
