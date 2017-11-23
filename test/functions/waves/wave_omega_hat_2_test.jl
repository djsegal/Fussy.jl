@testset "Wave Omega Hat 2 Function Tests" begin

  @test isdefined(Tokamak, :wave_omega_hat_2) == true

  Tokamak.load_input(" Z_eff = 1.0 ")
  Tokamak.load_input(" n_bar = 0.86 * 1u\"n20\" ")
  Tokamak.load_input(" B_0 = 10.0 * 1u\"T\" ")
  Tokamak.load_input(" R_0 = 4.0 * 1u\"m\" ")
  Tokamak.load_input(" T_k = 17.8 * 1u\"keV\" ")

  test_hash = Dict(
    0.0 => 0.372061572382137,
    0.5 => 0.455732127864706,
    1.0 => 0.0
  )

  for (cur_key, expected_value) in test_hash
    actual_value = Tokamak.wave_omega_hat_2(cur_key)

    @test isapprox(expected_value, actual_value, rtol=5e-4)
  end

end
