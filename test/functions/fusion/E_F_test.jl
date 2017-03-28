@testset "E F Function Tests" begin

  @test isdefined(Tokamak, :E_F) == true

  @test isapprox(Tokamak.E_F(), 17.6u"MeV")

end
