@testset "N Hat Function Tests" begin

  @test isdefined(Tokamak, :n_hat) == true

  Tokamak.load_input("nu_n = 0.4")

  expected_value = 1.145

  actual_value = n_hat()

  actual_value /= Tokamak.n_bar

  @test isapprox(expected_value, actual_value, rtol=5e-4)

end
