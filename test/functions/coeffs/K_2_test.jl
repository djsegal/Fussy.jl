@testset "K 2 Function Tests" begin

  @test isdefined(Tokamak, :K_2) == true

  Tokamak.load_input(" Q = 40 ")
  Tokamak.load_input(" f_DT = 0.9 ")
  Tokamak.load_input( "beta_N = $(Tokamak.max_beta_N)" )

  @test isapprox( Tokamak.K_2(), 3.65, rtol=1e-3 )

end
