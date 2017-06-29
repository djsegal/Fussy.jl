@testset "K Nu Function Tests" begin

  @test isdefined(Tokamak, :K_nu) == true

  @test isapprox( Tokamak.K_nu(), 2.948e-3 , rtol=5e-4 )

  Tokamak.load_input(" Q = 40 ")
  Tokamak.load_input(" f_DT = 0.9 ")

  @test isapprox( Tokamak.K_nu(), 3.57e-3 , rtol=5e-3 )

end
