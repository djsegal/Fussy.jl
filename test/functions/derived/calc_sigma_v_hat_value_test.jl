@testset "Calc Sigma V Hat Value Function Tests" begin

  @test isdefined(Tokamak, :calc_sigma_v_hat_value) == true

  @test_throws DomainError Tokamak.calc_sigma_v_hat_value()

end
