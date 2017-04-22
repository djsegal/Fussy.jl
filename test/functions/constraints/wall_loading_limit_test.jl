@testset "Wall Loading Limit Function Tests" begin

  @test isdefined(Tokamak, :wall_loading_limit) == true

  @test Tokamak.wall_loading_limit() != Nullable

end
