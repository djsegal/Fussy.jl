@testset "N Bar Function Tests" begin

  function get_test_n_bar(I_M)
    scale_factor = ( Sym("R_0") / 1u"m" ) ^ 2
    scale_factor /= 1u"n20"

    cur_n_bar = Tokamak.n_bar(I_M)
    cur_n_bar *= scale_factor

    SymPy.N(cur_n_bar)
  end

  @test isdefined(Tokamak, :n_bar) == true

  @test isapprox(get_test_n_bar(1u"MA"), 4.074, atol=1e-3)

  @test isapprox(get_test_n_bar(7u"MA"), 4.074*7, atol=5e-2)

  Tokamak.load_input( "R_0 = 3u\"m\"" )

  @test isapprox(Tokamak.n_bar(1u"MA")/1u"n20", 4.074/9, atol=5e-2)

end
