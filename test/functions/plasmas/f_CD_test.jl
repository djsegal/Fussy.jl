@testset "F CD Function Tests" begin

  @test isdefined(Tokamak, :f_CD) == true

  @test Tokamak.f_CD() != Nullable

end
