@testset "X Aa Of Pi Function Tests" begin

  @test isdefined(Fusion, :x_aa_of_pi) == true

  actual_value = x_aa_of_pi()

  expected_value = 0.225

  @test isapprox(expected_value, actual_value, rtol=5e-4)

end
