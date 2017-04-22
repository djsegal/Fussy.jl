@testset "S W Function Tests" begin

  @test isdefined(Tokamak, :S_W) == true

  @test Tokamak.S_W() != Nullable

end
