@testset "Steady State Function Tests" begin

  @test isdefined(Tokamak, :steady_state) == true

  @test Tokamak.steady_state() != Nullable

  Tokamak.load_input( "T_k = 15u\"keV\"" )

  Tokamak.load_input(" eta_CD = $(Tokamak.default_eta_CD) ")

  cur_steady_state = Tokamak.steady_state()
  cur_steady_state += 1

  cur_steady_state /= Tokamak.symbol_dict["n_bar"]
  cur_steady_state /= ( Tokamak.symbol_dict["R_0"] ) ^ 2

  cur_steady_state = SymPy.simplify( cur_steady_state |> NoUnits )

  sigma_v_hat, I_M = Sym("sigma_v_hat"), Sym("I_M")

  cur_steady_state = SymPy.subs( cur_steady_state , Tokamak.symbol_dict["I_M"] , I_M )
  cur_steady_state = SymPy.subs( cur_steady_state , Tokamak.symbol_dict["sigma_v_hat"] , sigma_v_hat )

  actual_value = SymPy.solve(cur_steady_state, I_M)[1]

  actual_value = Tokamak.calc_possible_values(actual_value, sigma_v_hat)

  expected_value = -1

  expected_value *= Tokamak.K_B()
  expected_value *= ( Tokamak.T_k / 1u"keV" )

  expected_value /= Tokamak.K_CD_hat()
  expected_value /= ( Tokamak.sigma_v_hat / 1u"m^3/s" )

  expected_value = Tokamak.calc_possible_values(expected_value)

  @test isapprox( expected_value , actual_value , rtol=5e-4 )

end
