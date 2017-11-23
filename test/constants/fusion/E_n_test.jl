@testset "E N Constant Tests" begin

  @test isdefined(Fusion, :E_n) == true

  @test isapprox(E_n, 14.1u"MeV")

end
