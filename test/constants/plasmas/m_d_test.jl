@testset "M D Constant Tests" begin

  @test isdefined(Tokamak, :m_d) == true

  @test isapprox(Tokamak.m_d, 2.0141018u"u")

end
