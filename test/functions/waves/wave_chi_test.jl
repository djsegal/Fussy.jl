@testset "Wave Chi Function Tests" begin

  @test isdefined(Tokamak, :wave_chi) == true

  Tokamak.load_input(" Z_eff = 1.0 ")
  Tokamak.load_input(" n_bar = 0.86 * 1u\"n20\" ")
  Tokamak.load_input(" B_0 = 10.0 * 1u\"T\" ")

  cur_solved_R_0 = 4.0
  cur_solved_T_k = 17.8

  test_hash = Dict(
    0.0 => 0.1151,
    0.5 => 0.1336,
    1.0 => 0.0000
  )

  for (cur_key, expected_value) in test_hash
    actual_value = Tokamak.wave_chi(cur_key)

    @test isapprox(expected_value, actual_value, rtol=1e-3)
  end

end
