@testset "C B Function Tests" begin

  @test isdefined(Tokamak, :C_B) == true

  @test isapprox( Tokamak.C_B() , 0.223642228 , rtol=5e-4 )

end
