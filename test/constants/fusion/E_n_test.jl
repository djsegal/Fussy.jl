@testset "E N Constant Tests" begin

  @test isdefined(Tokamak, :E_n) == true

  @test isapprox(Tokamak.E_n, 14.1u"MeV")

end
