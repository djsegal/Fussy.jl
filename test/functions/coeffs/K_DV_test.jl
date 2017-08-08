@testset "K DV Function Tests" begin

  @test isdefined(Tokamak, :K_DV) == true

  Tokamak.load_input(" Q = 40 ")
  Tokamak.load_input(" f_DT = 0.9 ")

  @test isapprox( Tokamak.K_DV(), 0.772 , rtol=1e-3 )

end
