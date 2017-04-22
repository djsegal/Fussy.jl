@testset "Calc Possible Values Function Tests" begin

  @test isdefined(Tokamak, :calc_possible_values) == true

  @test_throws DomainError Tokamak.calc_possible_values()

end
