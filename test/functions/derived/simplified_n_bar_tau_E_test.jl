@testset "Simplified N Bar Tau E Function Tests" begin

  @test isdefined(Tokamak, :simplified_n_bar_tau_E) == true

  expected_value = Tokamak.K_H()

  actual_value = Tokamak.simplified_n_bar_tau_E()

  actual_value /= 1u"s"
  actual_value /= 1u"n20"

  actual_value /= Tokamak.symbol_dict["B_0"] ^ ( 15 // 100 )
  actual_value *= Tokamak.symbol_dict["R_0"] ^ ( 16 // 100 )

  actual_value /= Tokamak.symbol_dict["T_k"] ^ ( 96 // 100 )

  actual_value *= Tokamak.symbol_dict["sigma_v_hat"] ^ ( 69 // 100 )

  actual_value *= Tokamak.symbol_dict["K_CD_denom"] ^ ( 96 // 100 )

  @test isapprox(expected_value, actual_value, rtol=5e-3)

end
