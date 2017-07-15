@testset "K W Function Tests" begin

  @test isdefined(Tokamak, :K_W) == true

  Tokamak.load_input(" f_DT = 0.9 ")

  @test isapprox( Tokamak.K_W() , 1.20 , rtol=5e-3 )

end
