@testset "E Alpha Constant Tests" begin

  @test isdefined(Tokamak, :E_alpha) == true

  @test isapprox(Tokamak.E_alpha, 3.5u"MeV")

end
