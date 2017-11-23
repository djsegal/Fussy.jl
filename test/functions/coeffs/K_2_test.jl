@testset "K 2 Function Tests" begin

  @test isdefined(Fusion, :K_2) == true

  Fusion.load_input(" Q = 40 ")
  Fusion.load_input(" f_DT = 0.9 ")
  Fusion.load_input( "beta_N = $(max_beta_N)" )

  @test isapprox( K_2(), 3.65, rtol=1e-3 )

end
