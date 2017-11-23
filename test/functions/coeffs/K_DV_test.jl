@testset "K DV Function Tests" begin

  @test isdefined(Fusion, :K_DV) == true

  Fusion.load_input(" Q = 40 ")
  Fusion.load_input(" f_DT = 0.9 ")

  @test isapprox( Fusion.K_DV(), 0.772 , rtol=1e-3 )

end
