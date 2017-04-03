@testset "P Kappa Function Tests" begin

  @test isdefined(Tokamak, :P_kappa) == true

  expected_value = Tokamak.K_kappa()

  actual_value = Tokamak.P_kappa()
  actual_value /= ( Tokamak.T_k / 1u"keV" )
  actual_value /= 1u"MW"

  actual_value /= Tokamak.symbol_dict["R_0"] ^ 3
  actual_value /= Tokamak.symbol_dict["n_bar"]
  actual_value *= Tokamak.symbol_dict["tau_E"]

  actual_value = SymPy.N(actual_value)

  @test isapprox( expected_value , actual_value )

end
