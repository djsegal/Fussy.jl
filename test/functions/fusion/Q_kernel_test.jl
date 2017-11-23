@testset "Q Kernel Function Tests" begin

  @test isdefined(Fusion, :Q_kernel) == true

  @test isapprox( Fusion.Q_kernel(40.0) , 0.2250 , rtol=5e-4 )

  @test isapprox( Fusion.Q_kernel(30.0) , 0.2333, rtol=5e-4 )

  @test isapprox( Fusion.Q_kernel(10.0) , 0.3000 , rtol=5e-4 )

end
