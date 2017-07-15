@testset "Solved R 0 From T K Function Tests" begin

  @test isdefined(Tokamak, :solved_R_0_from_T_k) == true

  @test Tokamak.solved_R_0_from_T_k(10.0) != Nullable

end
