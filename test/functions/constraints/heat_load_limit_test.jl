@testset "Heat Load Limit Function Tests" begin

  @test isdefined(Tokamak, :heat_load_limit) == true

  Tokamak.load_input( "h_parallel = $( Tokamak.max_h_parallel / ( 1u"MW" * 1u"T" / 1u"m" ) ) * ( 1u\"MW\" * 1u\"T\" / 1u\"m\" )" )

  @test Tokamak.wall_loading_limit() != Nullable

end
