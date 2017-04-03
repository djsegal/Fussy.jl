@testset "C B Function Tests" begin

  @test isdefined(Tokamak, :C_B) == true

  @test isapprox( Tokamak.C_B() , 0.2244 , rtol=1e-4 )

end
