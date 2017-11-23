@testset "E Alpha Constant Tests" begin

  @test isdefined(Fusion, :E_alpha) == true

  @test isapprox(Fusion.E_alpha, 3.5u"MeV")

end
