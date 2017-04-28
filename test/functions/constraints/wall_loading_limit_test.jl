@testset "Wall Loading Limit Function Tests" begin

  @test isdefined(Tokamak, :wall_loading_limit) == true

  Tokamak.load_input( "P_W = $( Tokamak.max_P_W / ( 1u"MW" / 1u"m^2" ) ) * ( 1u\"MW\" / 1u\"m^2\" )" )

  @test Tokamak.wall_loading_limit() != Nullable

end
