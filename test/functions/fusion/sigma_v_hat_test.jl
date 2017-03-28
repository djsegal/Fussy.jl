@testset "Sigma V Hat Function Tests" begin

  @test isdefined(Tokamak, :sigma_v_hat) == true

  @test Tokamak.sigma_v_hat() != Nullable

end
