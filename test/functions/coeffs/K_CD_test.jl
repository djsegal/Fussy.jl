@testset "K CD Function Tests" begin

  @test isdefined(Tokamak, :K_CD) == true

  Tokamak.load_input(" Q = 40 ")
  Tokamak.load_input(" f_DT = 0.9 ")

  @test isapprox( Tokamak.K_CD(), 0.634, rtol=5e-4 )

end
