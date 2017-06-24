@testset "B M Function Tests" begin

  @test isdefined(Tokamak, :B_M) == true

  Tokamak.load_input(" Z_eff = 1.0 ")
  Tokamak.load_input(" n_bar = 0.86 * 1u\"n20\" ")
  Tokamak.load_input(" B_0 = 10.0 * 1u\"T\" ")

  cur_solved_R_0 = 4.0
  cur_solved_T_k = 17.8

  test_hash = Dict(
    0.0 => 10.0000,
    0.5 => 11.4286,
    1.0 => 13.3333
  )

  for (cur_key, expected_value) in test_hash
    actual_value = Tokamak.B_M(cur_key)

    @test isapprox(expected_value, actual_value, rtol=5e-4)
  end

end
