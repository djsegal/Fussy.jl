@testset "K Rad Function Tests" begin

  @test isdefined(Tokamak, :K_rad) == true

  @test isapprox( Tokamak.K_rad(), 2.031e-2 , rtol=5e-4 )

end
