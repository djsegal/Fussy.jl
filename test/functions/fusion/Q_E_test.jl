@testset "Q E Function Tests" begin

  @test isdefined(Fusion, :Q_E) == true

  @test isapprox( Fusion.Q_E(), 9.342 , rtol=5e-5 )

  Fusion.load_input(" eta_RF = 0.5 ")

  @test isapprox( Fusion.Q_E(40.0), 9.382 , rtol=5e-4 )

  @test isapprox( Fusion.Q_E(30.0), 6.84 , rtol=5e-3 )

  @test isapprox( Fusion.Q_E(10.0), 1.75 , rtol=5e-3 )

end
