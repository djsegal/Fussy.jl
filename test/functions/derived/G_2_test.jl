@testset "G 2 Function Tests" begin

  @test isdefined(Fusion, :G_2) == true

  expected_value = Fusion.symbol_dict["T_k"]

  actual_value = G_2()

  @test isapprox(expected_value, actual_value, rtol=5e-4)

end
