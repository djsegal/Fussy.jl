@testset "Heat Load Limit Function Tests" begin

  @test isdefined(Tokamak, :heat_load_limit) == true

  @test Tokamak.wall_loading_limit() != Nullable

end
