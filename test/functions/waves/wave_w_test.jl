@testset "Wave W Function Tests" begin

  @test isdefined(Tokamak, :wave_w) == true

  Tokamak.load_input(" Z_eff = 1.0 ")
  Tokamak.load_input(" n_bar = 0.86 * 1u\"n20\" ")
  Tokamak.load_input(" B_0 = 10.0 * 1u\"T\" ")
  Tokamak.load_input(" R_0 = 4.0 * 1u\"m\" ")
  Tokamak.load_input(" T_k = 17.8 * 1u\"keV\" ")

  cur_n_para_m = 1.473416371493217
  cur_rho_m = 0.773925336996854

  expected_value = 2.999409995184309

  actual_value = subs(
    Tokamak.wave_w(cur_rho_m),
    Tokamak.symbol_dict["n_para"],
    cur_n_para_m
  )

  @test isapprox(expected_value, actual_value, rtol=5e-4)

end
