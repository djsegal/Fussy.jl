@testset "Q E Function Tests" begin

  @test isdefined(Tokamak, :Q_E) == true

  @test isapprox(Tokamak.Q_E(), 9.34)

end
