@testset "K F Function Tests" begin

  @test isdefined(Fusion, :K_F) == true

  Fusion.load_input(" f_DT = 0.9 ")

  @test isapprox( K_F(), 25.36 , rtol=5e-5 )

  Fusion.load_input(" f_DT = 1.0 ")

  @test isapprox( K_F(), 31.31 , rtol=5e-5 )

end
