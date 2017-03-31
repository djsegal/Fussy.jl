@testset "Greenwald Limit Function Tests" begin

  @test isdefined(Tokamak, :greenwald_limit) == true

  function get_test_greenwald_limit()
    scale_factor = ( Sym("R_0") ) ^ 2
    scale_factor /= Sym("I_M")
    scale_factor /= 1u"n20"

    cur_greenwald_limit = Tokamak.greenwald_limit()
    cur_greenwald_limit += Tokamak.n_bar
    cur_greenwald_limit *= scale_factor

    cur_greenwald_limit
  end

  expected_value = 4.074
  actual_value = get_test_greenwald_limit()

  @test isapprox(expected_value, SymPy.N(actual_value), atol=1e-3)

  Tokamak.load_input( "I_M = 7u\"MA\"" )

  expected_value *= 7
  actual_value = get_test_greenwald_limit()
  actual_value *= Sym("I_M")

  @test isapprox(expected_value, SymPy.N(actual_value), atol=5e-3)

  Tokamak.load_input( "R_0 = 3u\"m\"" )

  expected_value /= 9
  actual_value = get_test_greenwald_limit()
  actual_value *= Sym("I_M")
  actual_value /= Sym("R_0") ^ 2

  @test isapprox(expected_value, SymPy.N(actual_value), atol=5e-3)

end
