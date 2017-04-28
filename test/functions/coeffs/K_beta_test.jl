@testset "K Beta Function Tests" begin

  @test isdefined(Tokamak, :K_beta) == true

  Tokamak.load_input( "beta_N = $(Tokamak.max_beta_N)" )

  @test isapprox( Tokamak.K_beta(), 3.609, rtol=5e-4 )

end
