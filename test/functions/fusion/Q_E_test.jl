@testset "Q E Function Tests" begin

  @test isdefined(Tokamak, :Q_E) == true

  @test isapprox( Tokamak.Q_E(), 9.342 , rtol=5e-5 )

  Tokamak.load_input(" Q = 40 ")
  Tokamak.load_input(" eta_RF = 0.5 ")

  @test isapprox( Tokamak.Q_E(), 9.382 , rtol=5e-4 )

end
