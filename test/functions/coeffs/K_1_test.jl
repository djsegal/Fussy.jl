@testset "K 1 Function Tests" begin

  @test isdefined(Tokamak, :K_1) == true

  Tokamak.load_input(" Q = 40 ")
  Tokamak.load_input(" f_DT = 0.9 ")

  @test isapprox( Tokamak.K_1(), 0.5572, rtol=5e-4 )

end
