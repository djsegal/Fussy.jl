@testset "Power Sinks Function Tests" begin

  @test isdefined(Tokamak, :power_sinks) == true

  @test Tokamak.power_sinks() != Nullable

end
