@testset "E F Function Tests" begin

  @test isdefined(Fusion, :E_F) == true

  @test isapprox(Fusion.E_F(), 17.6u"MeV")

end
