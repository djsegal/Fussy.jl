@testset "K DV Function Tests" begin

  @test isdefined(Tokamak, :K_DV) == true

  @test isapprox( Tokamak.K_DV(), 1.958e-2 , rtol=1e-3 )

end
