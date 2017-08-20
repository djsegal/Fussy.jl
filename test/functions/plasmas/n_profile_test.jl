@testset "N Profile Function Tests" begin

  @test isdefined(Tokamak, :n_profile) == true

  Tokamak.load_input(" Z_eff = 1.0 ")
  Tokamak.load_input(" n_bar = 0.86 * 1u\"n20\" ")
  Tokamak.load_input(" B_0 = 10.0 * 1u\"T\" ")

  cur_solved_R_0 = 4.0
  cur_solved_T_k = 17.8

  test_hash = Dict(
    0.0 => 1.1180,
    0.5 => 1.0256,
    1.0 => 0.0000
  )

  for (cur_key, expected_value) in test_hash
    actual_value = Tokamak.n_profile(cur_key)

    @test isapprox(expected_value, actual_value, rtol=5e-4)
  end

end
