@testset "F RP Function Tests" begin

  @test isdefined(Tokamak, :f_RP) == true

  @test isapprox( Tokamak.f_RP() , 0.0967 , rtol=1e-4 )

  Tokamak.load_input(" eta_RF = 0.5 ")

  @test isapprox( Tokamak.f_RP(40.0) , 0.0963 , rtol=5e-4 )

  @test isapprox( Tokamak.f_RP(30.0) , 0.128 , rtol=5e-3 )

  @test isapprox( Tokamak.f_RP(10.0) , 0.364 , rtol=5e-3 )

end
