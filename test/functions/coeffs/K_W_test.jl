@testset "K W Function Tests" begin

  @test isdefined(Tokamak, :K_W) == true

  Tokamak.load_input( "max_P_W = 2.5 * ( 1u\"MW\" / 1u\"m^2\" )" )

  Tokamak.load_input( "P_W = $( Tokamak.max_P_W / ( 1u"MW" / 1u"m^2" ) ) * ( 1u\"MW\" / 1u\"m^2\" )" )

  println(Tokamak.K_W())
  @test isapprox( Tokamak.K_W() , 0.7764 , rtol=5e-4 )

end
