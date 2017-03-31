@testset "I CD Function Tests" begin

  @test isdefined(Tokamak, :I_CD) == true

  @test Tokamak.I_CD() != Nullable

end
