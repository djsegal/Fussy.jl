@testset "F RP Function Tests" begin

  @test isdefined(Tokamak, :f_RP) == true

  @test isapprox( Tokamak.f_RP() , 0.0967 , rtol=1e-4 )

  Tokamak.load_input(" Q = 40 ")
  Tokamak.load_input(" eta_RF = 0.5 ")

  @test isapprox( Tokamak.f_RP() , 0.0963 , rtol=5e-4 )

end
