@testset "K W Function Tests" begin

  @test isdefined(Fusion, :K_W) == true

  Fusion.load_input(" f_DT = 0.9 ")

  @test isapprox( K_W() , 1.20 , rtol=5e-3 )

end
