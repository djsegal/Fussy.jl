@testset "Q E Function Tests" begin

  @test isdefined(Tokamak, :Q_E) == true

  @test isapprox( Tokamak.Q_E(), 9.342 , rtol=5e-5 )

end
