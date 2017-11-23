@testset "K LH Function Tests" begin

  @test isdefined(Fusion, :K_LH) == true

  Fusion.load_input(" eta_CD = $(Fusion.default_eta_CD) ")

  @test isapprox( Fusion.K_LH(), 0.8929, rtol=5e-4 )

  Fusion.load_input(" Q = 40 ")
  Fusion.load_input(" f_DT = 0.9 ")

  @test isapprox( Fusion.K_LH(), 0.903, rtol=5e-3 )

end
