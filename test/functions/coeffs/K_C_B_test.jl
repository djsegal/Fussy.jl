@testset "K C B Function Tests" begin

  @test isdefined(Tokamak, :K_C_B) == true

  @test isapprox( Tokamak.K_C_B() , 0.2244 , rtol=1e-4 )

end
