@testset "E N Constant Tests" begin

  @test isdefined(Fusion, :E_n) == true

  @test isapprox(Fusion.E_n, 14.1u"MeV")

end
