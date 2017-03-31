@testset "Steady State Function Tests" begin

  @test isdefined(Tokamak, :steady_state) == true

  @test Tokamak.steady_state(1u"MA") != Nullable

end
