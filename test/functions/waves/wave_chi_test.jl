@testset "Wave Chi Function Tests" begin

  @test isdefined(Fusion, :wave_chi) == true

  Fusion.load_input(" Z_eff = 1.0 ")
  Fusion.load_input(" n_bar = 0.86 * 1u\"n20\" ")
  Fusion.load_input(" B_0 = 10.0 * 1u\"T\" ")
  Fusion.load_input(" R_0 = 4.0 * 1u\"m\" ")
  Fusion.load_input(" T_k = 17.8 * 1u\"keV\" ")

  test_hash = Dict(
    0.0 => 0.115022303907001,
    0.5 => 0.133538190241175,
    1.0 => 0.0
  )

  for (cur_key, expected_value) in test_hash
    actual_value = wave_chi(cur_key)

    @test isapprox(expected_value, actual_value, rtol=5e-4)
  end

end
