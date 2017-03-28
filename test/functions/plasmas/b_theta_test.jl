@testset "B Theta Function Tests" begin

  @test isdefined(Tokamak, :b_theta) == true

  @test Tokamak.b_theta(1) != Nullable

end
