@testset "E Li Constant Tests" begin

  @test isdefined(Fusion, :E_Li) == true

  @test isapprox(Fusion.E_Li, 4.8u"MeV")

end
