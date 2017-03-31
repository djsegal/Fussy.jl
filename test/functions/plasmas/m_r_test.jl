@testset "M R Function Tests" begin

  @test isdefined(Tokamak, :m_r) == true

  @test isapprox(Tokamak.m_r()/1u"u", 1.2076, rtol=5e-5)

end
