@testset "Vst PF Function Tests" begin

  Tokamak.load_input(" R_0 = 3.3 * 1u\"m\" ")
  Tokamak.load_input(" B_0 = 9.2 * 1u\"T\" ")
  Tokamak.load_input(" I_M = 8 * 1u\"MA\" ")
  Tokamak.load_input(" T_k = 15 * 1u\"keV\" ")
  Tokamak.load_input(" n_bar = 1.5 * 1u\"n20\" ")
  Tokamak.load_input(" delta = 0.45 ")
  Tokamak.load_input(" epsilon = 0.3424242424 ")
  Tokamak.load_input(" enable_blanket_derive = false ")

  actual_value = Tokamak.Vst_PF()

  expected_value = [
    0.160111301774865,2.483271254393967,0.835328051003438,
    0.171819000413094,2.312592536721197,1.391766224089625,
    0.366143933388165,0.882769508827095,0.724498532721720,
    1.407557193318278
  ]

  @test length(actual_value) == length(expected_value)

  for cur_index in 1:length(expected_value)
    @test isapprox(expected_value[cur_index], actual_value[cur_index], rtol=5e-4)
  end

end
