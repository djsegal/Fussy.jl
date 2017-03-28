@testset "M T Constant Tests" begin

  @test isdefined(Tokamak, :m_t) == true

  @test isapprox(Tokamak.m_t, 3.0160492u"u")

end
