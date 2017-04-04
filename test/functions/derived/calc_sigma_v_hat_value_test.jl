@testset "Calc Sigma V Hat Value Function Tests" begin

  @test isdefined(Tokamak, :calc_sigma_v_hat_value) == true

  @test Tokamak.calc_sigma_v_hat_value() != Nullable

end
