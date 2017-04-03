@testset "Greenwald Limit Function Tests" begin

  @test isdefined(Tokamak, :greenwald_limit) == true

  function get_test_greenwald_limit()
    scale_factor = Tokamak.symbol_dict["R_0"] ^ 2
    scale_factor /= Tokamak.symbol_dict["I_M"]

    cur_greenwald_limit = Tokamak.greenwald_limit()
    cur_greenwald_limit += ( Tokamak.n_bar / 1u"n20" )
    cur_greenwald_limit *= scale_factor

    cur_greenwald_limit
  end

  expected_value = 4.074
  actual_value = get_test_greenwald_limit()

  @test isapprox(expected_value, SymPy.N(actual_value), rtol=1e-4)

  Tokamak.load_input( "I_M = 7u\"MA\"" )

  expected_value *= 7
  actual_value = get_test_greenwald_limit()
  actual_value *= Tokamak.symbol_dict["I_M"]

  @test isapprox(expected_value, SymPy.N(actual_value), rtol=1e-4)

  Tokamak.load_input( "R_0 = 3u\"m\"" )

  expected_value /= 9
  actual_value = get_test_greenwald_limit()
  actual_value *= Tokamak.symbol_dict["I_M"]
  actual_value /= Tokamak.symbol_dict["R_0"] ^ 2

  @test isapprox(expected_value, SymPy.N(actual_value), rtol=1e-4)

end
