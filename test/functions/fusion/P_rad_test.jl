@testset "P Rad Function Tests" begin

  @test isdefined(Tokamak, :P_rad) == true

  @test Tokamak.P_rad() != Nullable

end
