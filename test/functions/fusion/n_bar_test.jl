@testset "N Bar Function Tests" begin

  @test isdefined(Tokamak, :n_bar) == true

  @test isapprox(Tokamak.n_bar(1u"m", 1u"MA"), 4.074, atol=1e-3)

  @test isapprox(Tokamak.n_bar(3u"m", 1u"MA"), 4.074/9, atol=5e-2)

  @test isapprox(Tokamak.n_bar(1u"m", 7u"MA"), 4.074*7, atol=5e-2)

end
