@testset "R B Eq From Ignition Function Tests" begin

  @test isdefined(Tokamak, :r_b_eq_from_ignition) == true

  (Tokamak.r_b_eq_from_ignition())

end
