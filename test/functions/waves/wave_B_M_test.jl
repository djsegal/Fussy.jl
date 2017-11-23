@testset "Wave B M Function Tests" begin

  @test isdefined(Fusion, :wave_B_M) == true

  Fusion.load_input(" Z_eff = 1.0 ")
  Fusion.load_input(" n_bar = 0.86 * 1u\"n20\" ")
  Fusion.load_input(" B_0 = 10.0 * 1u\"T\" ")
  Fusion.load_input(" R_0 = 4.0 * 1u\"m\" ")
  Fusion.load_input(" T_k = 17.8 * 1u\"keV\" ")

  test_hash = Dict(
    0.0 => 10.0000,
    0.5 => 11.4286,
    1.0 => 13.3333
  )

  for (cur_key, expected_value) in test_hash
    actual_value = Fusion.wave_B_M(cur_key)

    actual_value /= 1u"T"

    @test isapprox(expected_value, actual_value, rtol=5e-4)
  end

end
