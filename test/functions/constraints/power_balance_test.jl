@testset "Power Balance Function Tests" begin

  @test isdefined(Tokamak, :power_balance) == true

  @test Tokamak.power_balance() != Nullable

end
