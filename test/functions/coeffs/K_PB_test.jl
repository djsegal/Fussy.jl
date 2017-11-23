@testset "K PB Function Tests" begin

  @test isdefined(Fusion, :K_PB) == true

  Fusion.load_input(" Q = 40 ")
  Fusion.load_input(" f_DT = 0.9 ")

  actual_value = K_PB()

  expected_value = 5.69

  @test isapprox(expected_value, actual_value, rtol=5e-3)

end
