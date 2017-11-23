@testset "B Theta Function Tests" begin

  @test isdefined(Fusion, :b_theta) == true

  @test Fusion.b_theta(0.5) != Nullable

  @test Fusion.b_theta(1.0) == 1.0

end
