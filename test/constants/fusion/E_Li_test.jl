@testset "E Li Constant Tests" begin

  @test isdefined(Tokamak, :E_Li) == true

  @test isapprox(Tokamak.E_Li, 4.8u"MeV")

end
