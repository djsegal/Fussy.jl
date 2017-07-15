@testset "K F Function Tests" begin

  @test isdefined(Tokamak, :K_F) == true

  Tokamak.load_input(" f_DT = 0.9 ")

  @test isapprox( Tokamak.K_F(), 25.36 , rtol=5e-5 )

  Tokamak.load_input(" f_DT = 1.0 ")

  @test isapprox( Tokamak.K_F(), 31.31 , rtol=5e-5 )

end
