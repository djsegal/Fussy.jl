@testset "Wave B Function Tests" begin

  @test isdefined(Tokamak, :wave_B) == true

  Tokamak.load_input(" Z_eff = 1.0 ")
  Tokamak.load_input(" n_bar = 0.86 * 1u\"n20\" ")
  Tokamak.load_input(" B_0 = 10.0 * 1u\"T\" ")
  Tokamak.load_input(" R_0 = 4.0 * 1u\"m\" ")
  Tokamak.load_input(" T_k = 17.8 * 1u\"keV\" ")

  test_hash = Dict(
    0.0 => Dict(
      0.0 => 10,
      180.0 => 10
    ),
    0.5 => Dict(
      0.0 => 8.8889,
      180.0 => 11.4286
    ),
    1.0 => Dict(
      0.0 => 8.0,
      180.0 => 13.3333
    )
  )

  for (cur_key, sub_hash) in test_hash
    for (cur_sub_key, expected_value) in sub_hash
      actual_value = Tokamak.wave_B(cur_key, cur_sub_key)

      actual_value /= 1u"T"

      @test isapprox(expected_value, actual_value, rtol=5e-4)
    end
  end

end
