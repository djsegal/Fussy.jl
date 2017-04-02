@testset "Calculate Sigma V Hat Function Tests" begin

  @test isdefined(Tokamak, :calculate_sigma_v_hat) == true

  @test Tokamak.calculate_sigma_v_hat() != Nullable

end
