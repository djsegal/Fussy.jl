@testset "Steady State Function Tests" begin

  @test isdefined(Tokamak, :steady_state) == true

  @test Tokamak.steady_state() != Nullable

  Tokamak.load_input( "T_k = 15u\"keV\"" )

  cur_steady_state = Tokamak.steady_state()
  cur_steady_state += 1

  cur_steady_state /= Sym("n_bar")
  cur_steady_state /= ( Sym("R_0") ) ^ 2

  cur_steady_state = SymPy.simplify( cur_steady_state |> NoUnits )

  actual_value = SymPy.solve(cur_steady_state, Sym("I_M"))[1]

  expected_value = -( 0.07181 / 0.2192 )
  expected_value *= ( Tokamak.T_k / 1u"keV" )
  expected_value /= ( Tokamak.sigma_v_hat / 1u"m^3/s" )

  actual_value = Tokamak.calculate_sigma_v_hat(actual_value)
  expected_value = Tokamak.calculate_sigma_v_hat(expected_value)

  @test isapprox( expected_value , actual_value , rtol=5e-4 )

end
