@testset "Solved Steady Current Function Tests" begin

  @test isdefined(Tokamak, :solved_steady_current) == true

  expected_value = 1.0

  actual_value = Tokamak.solved_steady_current()

  actual_value /= Tokamak.simplified_current()

  actual_value = SymPy.N(actual_value)

  @test isapprox( expected_value , actual_value )

end
