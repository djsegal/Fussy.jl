@testset "K LH Function Tests" begin

  @test isdefined(Tokamak, :K_LH) == true

  Tokamak.load_input(" eta_CD = $(Tokamak.default_eta_CD) ")

  @test isapprox( Tokamak.K_LH(), 0.8929, rtol=5e-4 )

  Tokamak.load_input(" Q = 40 ")
  Tokamak.load_input(" f_DT = 0.9 ")

  @test isapprox( Tokamak.K_LH(), 0.903, rtol=5e-3 )

end
