@testset "Solved Steady Density Function Tests" begin

  @test isdefined(Tokamak, :solved_steady_density) == true

  expected_value = 1.0

  actual_value = Tokamak.solved_steady_density()

  actual_value /= Tokamak.simplified_density()

  actual_value = SymPy.N(actual_value)

  @test isapprox( expected_value , actual_value )

end
