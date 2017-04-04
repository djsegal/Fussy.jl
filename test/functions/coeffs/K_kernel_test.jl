@testset "K Kernel Function Tests" begin

  @test isdefined(Tokamak, :K_kernel) == true

  @test isapprox( Tokamak.K_kernel(), 4.074, rtol=5e-4 )

end
