@testset "K DV Function Tests" begin

  @test isdefined(Tokamak, :K_DV) == true

  Tokamak.load_input( "h_parallel = $( Tokamak.max_h_parallel / ( 1u"MW" * 1u"T" / 1u"m" ) ) * ( 1u\"MW\" * 1u\"T\" / 1u\"m\" )" )

  @test isapprox( Tokamak.K_DV(), 1.958e-2 , rtol=1e-3 )

end
