@testset "A Function Tests" begin

  @test isdefined(Tokamak, :a) == true

  @test isapprox( Tokamak.a(1u"m") , 0.25u"m" )
  @test isapprox( Tokamak.a(4u"m") , 1.0u"m" )

  @eval Tokamak.@load_input "epsilon = 1"

  @test isapprox( Tokamak.a(1u"m") , 1u"m" )
  @test isapprox( Tokamak.a(4u"m") , 4u"m" )

end
