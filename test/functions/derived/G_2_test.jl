@testset "G 2 Function Tests" begin

  @test isdefined(Tokamak, :G_2) == true

  expected_value = Tokamak.symbol_dict["T_k"]

  actual_value = Tokamak.G_2()

  @test isapprox(expected_value, actual_value, rtol=5e-4)

end
