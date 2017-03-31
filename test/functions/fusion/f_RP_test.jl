@testset "F RP Function Tests" begin

  @test isdefined(Tokamak, :f_RP) == true

  @test isapprox( Tokamak.f_RP() , 0.0967 , rtol=1e-4 )

end
