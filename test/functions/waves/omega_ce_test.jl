@testset "Omega Ce Function Tests" begin

  @test isdefined(Tokamak, :omega_ce) == true

  Tokamak.load_input(" Z_eff = 1.0 ")
  Tokamak.load_input(" n_bar = 0.86 * 1u\"n20\" ")
  Tokamak.load_input(" T_k = 17.8 * 1u\"keV\" ")

  cur_solved_R_0 = 4.0
  cur_solved_B_0 = 10.0

  test_hash = Dict(
    0.0 => 1.7588e12,
    0.5 => 1.5634e12,
    1.0 => 1.4071e12
  )

  for (cur_key, expected_value) in test_hash
    actual_value = Tokamak.omega_ce(cur_key)

    actual_value = subs(
      actual_value, Tokamak.symbol_dict["B_0"], cur_solved_B_0
    )

    @test isapprox(expected_value, actual_value, rtol=5e-4)
  end

end
