@testset "T Profile Function Tests" begin

  @test isdefined(Tokamak, :T_profile) == true

  Tokamak.load_input(" Z_eff = 1.0 ")
  Tokamak.load_input(" n_bar = 0.86 * 1u\"n20\" ")
  Tokamak.load_input(" B_0 = 10.0 * 1u\"T\" ")

  cur_solved_R_0 = 4.0
  cur_solved_T_k = 17.8

  test_hash = Dict(
    0.0 => 39.1600,
    0.5 => 27.7279,
    1.0 => 0.00000
  )

  for (cur_key, expected_value) in test_hash
    actual_value = Tokamak.T_profile(cur_key)

    actual_value = subs(
      actual_value, Tokamak.symbol_dict["T_k"], cur_solved_T_k
    )

    @test isapprox(expected_value, actual_value, rtol=5e-4)
  end

end