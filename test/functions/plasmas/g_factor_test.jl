@testset "G Factor Function Tests" begin

  @test isdefined(Tokamak, :g_factor) == true

  Tokamak.load_input(" enable_geom_factor = true ")

  @test isapprox( Tokamak.g_factor(0.0) , 1.09 , rtol=1e-2 )

  @test isapprox( Tokamak.g_factor(1.0) , 0.88 , rtol=1e-2 )

end
