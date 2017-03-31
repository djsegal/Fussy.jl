@testset "K F Function Tests" begin

  @test isdefined(Tokamak, :K_F) == true

  @test isapprox(Tokamak.K_F(), 31.31, rtol=5e-5)

end
