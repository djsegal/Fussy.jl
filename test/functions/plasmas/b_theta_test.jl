@testset "B Theta Function Tests" begin

  @test isdefined(Tokamak, :b_theta) == true

  @test Tokamak.b_theta(0.5) != Nullable

  @test Tokamak.b_theta(1.0) == 1.0

end
