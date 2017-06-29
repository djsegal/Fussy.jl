@testset "K PB Function Tests" begin

  @test isdefined(Tokamak, :K_PB) == true

  Tokamak.load_input(" Q = 40 ")
  Tokamak.load_input(" f_DT = 0.9 ")

  actual_value = Tokamak.K_PB()

  expected_value = 5.69

  println(actual_value)

  @test isapprox(expected_value, actual_value, rtol=5e-4)

end
