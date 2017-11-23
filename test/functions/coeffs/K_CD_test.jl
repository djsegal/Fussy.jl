@testset "K CD Function Tests" begin

  @test isdefined(Fusion, :K_CD) == true

  Fusion.load_input(" Q = 40 ")
  Fusion.load_input(" f_DT = 0.9 ")

  @test isapprox( K_CD(), 0.634, rtol=5e-4 )

end
