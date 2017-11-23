@testset "Wave Rho J Function Tests" begin

  @test isdefined(Tokamak, :wave_rho_j) == true

  Tokamak.load_input(" Z_eff = 1.0 ")
  Tokamak.load_input(" n_bar = 0.86 * 1u\"n20\" ")
  Tokamak.load_input(" B_0 = 10.0 * 1u\"T\" ")
  Tokamak.load_input(" R_0 = 4.0 * 1u\"m\" ")
  Tokamak.load_input(" T_k = 17.8 * 1u\"keV\" ")

  cur_n_para_m = 1.473416371493217
  cur_rho_j = 0.698983890732823

  expected_value = 0.773925336996854

  actual_value = Tokamak.wave_rho_j(cur_rho_j, cur_n_para_m)

  @test isapprox(expected_value, actual_value, rtol=5e-4)

end
