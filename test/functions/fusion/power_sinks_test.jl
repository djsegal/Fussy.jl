@testset "Power Sinks Function Tests" begin

  @test isdefined(Fusion, :power_sinks) == true

  @test power_sinks() != Nullable

end
