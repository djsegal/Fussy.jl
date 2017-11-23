@testset "C B Function Tests" begin

  @test isdefined(Fusion, :C_B) == true

  @test isapprox( C_B() , 0.22364 , rtol=1e-4 )

end
