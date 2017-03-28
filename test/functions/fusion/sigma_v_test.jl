@testset "Sigma V Function Tests" begin

  @test isdefined(Tokamak, :sigma_v) == true

  @test Tokamak.sigma_v() != Nullable

end
