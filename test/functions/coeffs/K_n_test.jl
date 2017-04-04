@testset "K N Function Tests" begin

  @test isdefined(Tokamak, :K_n) == true

  @test isapprox( Tokamak.K_n(), 1.193, rtol=1e-3 )

end
