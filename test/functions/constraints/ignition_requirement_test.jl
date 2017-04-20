@testset "Ignition Requirement Function Tests" begin

  @test isdefined(Tokamak, :ignition_requirement) == true

  @test Tokamak.ignition_requirement() != Nullable

end
