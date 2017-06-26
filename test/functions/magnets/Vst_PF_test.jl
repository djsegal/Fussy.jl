@testset "Vst PF Function Tests" begin

  Tokamak.load_input(" R_0 = 6.3 * 1u\"m\" ")
  Tokamak.load_input(" B_0 = 5.2 * 1u\"T\" ")
  Tokamak.load_input(" I_M = 15 * 1u\"MA\" ")
  Tokamak.load_input(" T_k = 15 * 1u\"keV\" ")
  Tokamak.load_input(" n_bar = 1.5 * 1u\"n20\" ")
  Tokamak.load_input(" nu_T = 1.3 ")
  Tokamak.load_input(" nu_n = 0.5 ")
  Tokamak.load_input(" delta = 0.45 ")
  Tokamak.load_input(" epsilon = 0.3174603175 ")
  Tokamak.load_input(" enable_blanket_derive = false ")

  actual_value = Tokamak.Vst_PF()

  expected_value = [1.835860216345909,1.835860216345909,7.322668980610272,7.322668980610272,15.675463284060012,15.675463284060012,3.520990606828261,3.520990606828261,2.958868453350746,2.958868453350746]

  @test length(actual_value) == length(expected_value)

  for cur_index = 1:length(expected_value)
    @test isapprox(expected_value[cur_index], actual_value[cur_index], rtol=5e-4)
  end

end
