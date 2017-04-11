@testset "K W Function Tests" begin

  @test isdefined(Tokamak, :K_W) == true

  println(Tokamak.K_W())

end
