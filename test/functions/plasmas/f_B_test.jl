@testset "F B Function Tests" begin

  @test isdefined(Tokamak, :f_B) == true

  @test Tokamak.f_B() != Nullable

end
