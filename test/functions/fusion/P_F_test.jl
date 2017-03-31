@testset "P F Function Tests" begin

  @test isdefined(Tokamak, :P_F) == true

  @test Tokamak.P_F() != Nullable

end
