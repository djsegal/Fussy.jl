@testset "K F Function Tests" begin

  @test isdefined(Tokamak, :K_F) == true

  @test isapprox(Tokamak.K_F(), 31.31, atol=5e-2)

end
