@testset "P Bar Function Tests" begin

  @test isdefined(Tokamak, :p_bar) == true

  Tokamak.load_input("nu_n = 0.4")
  Tokamak.load_input("nu_T = 1.1")

  expected_value = 0.3580

  actual_value = ( p_bar() / 1u"bar" )

  actual_value /= ( Tokamak.n_bar / 1u"n20" )

  actual_value /= ( Tokamak.T_k / 1u"keV" )

  @test isapprox(expected_value, actual_value, rtol=5e-4)

end
