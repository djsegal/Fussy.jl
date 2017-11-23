@testset "E F Function Tests" begin

  @test isdefined(Fusion, :E_F) == true

  @test isapprox(E_F(), 17.6u"MeV")

end
