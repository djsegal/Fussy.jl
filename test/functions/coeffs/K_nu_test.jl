@testset "K Nu Function Tests" begin

  @test isdefined(Fusion, :K_nu) == true

  @test isapprox( K_nu(), 2.948e-3 , rtol=5e-4 )

  Fusion.load_input(" Q = 40 ")
  Fusion.load_input(" f_DT = 0.9 ")

  @test isapprox( K_nu(), 3.57e-3 , rtol=5e-3 )

end
