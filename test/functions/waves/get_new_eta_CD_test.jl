@testset "Get New Eta CD Function Tests" begin

  @test isdefined(Tokamak, :get_new_eta_CD) == true

  Tokamak.load_input(" Z_eff = 1.0 ")
  Tokamak.load_input(" n_bar = 0.86 * 1u\"n20\" ")
  Tokamak.load_input(" B_0 = 10.0 * 1u\"T\" ")

  cur_solved_R_0 = 4.0
  cur_solved_T_k = 17.8

  actual_value = Tokamak.get_new_eta_CD(cur_solved_R_0, cur_solved_T_k)

  expected_value = 0.36657

  @test isapprox(expected_value, actual_value, rtol=5e-4)

end
