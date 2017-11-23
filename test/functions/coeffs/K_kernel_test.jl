@testset "K Kernel Function Tests" begin

  @test isdefined(Fusion, :K_kernel) == true

  @test isapprox( Fusion.K_kernel(), 4.074, rtol=5e-4 )

end
