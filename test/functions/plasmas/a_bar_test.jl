@testset "A Bar Function Tests" begin

  @test isdefined(Tokamak, :a_bar) == true

  @test isapprox( Tokamak.a_bar(4u"m") , 1.342u"m" , atol=5e-3u"m" )

end
