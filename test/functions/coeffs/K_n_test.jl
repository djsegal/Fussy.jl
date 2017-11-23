@testset "K N Function Tests" begin

  @test isdefined(Fusion, :K_n) == true

  @test isapprox( K_n(), 1.208, rtol=1e-3 )

end
