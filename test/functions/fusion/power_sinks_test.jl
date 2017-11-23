@testset "Power Sinks Function Tests" begin

  @test isdefined(Fusion, :power_sinks) == true

  @test Fusion.power_sinks() != Nullable

end
