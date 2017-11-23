@testset "B Theta Function Tests" begin

  @test isdefined(Fusion, :b_theta) == true

  @test b_theta(0.5) != Nullable

  @test b_theta(1.0) == 1.0

end
