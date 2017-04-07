@testset "Reduced Beta Function Tests" begin

  @test isdefined(Tokamak, :reduced_beta) == true

  @test Tokamak.reduced_beta() != Nullable

end
