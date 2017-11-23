@testset "K BR Function Tests" begin

  @test isdefined(Tokamak, :K_BR) == true

  @test isapprox( Tokamak.K_BR(), 2.031e-2 , rtol=5e-4 )

  Tokamak.load_input("nu_n = 0.4")
  Tokamak.load_input("nu_T = 1.1")

  Tokamak.load_input("delta = 0.4")
  Tokamak.load_input("Z_eff = 1.5")

  Tokamak.load_input(" cur_enable_geom_scaling = true ")

  expected_value = 0.1903

  actual_value = K_BR()

  actual_value /= Tokamak.epsilon ^ 2

  actual_value /= Tokamak.kappa

  @test isapprox(expected_value, actual_value, rtol=1e-3)

end
