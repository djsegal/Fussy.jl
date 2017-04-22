@testset "R B Eq From Wall Loading Function Tests" begin

  @test isdefined(Tokamak, :r_b_eq_from_wall_loading) == true

  actual_value = Tokamak.r_b_eq_from_wall_loading()

  actual_value += Tokamak.symbol_dict["R_0"]
  actual_value ^= 3

  println(actual_value)

end
