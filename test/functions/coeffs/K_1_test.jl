@testset "K 1 Function Tests" begin

  @test isdefined(Tokamak, :K_1) == true

  println(Tokamak.K_1())

end
