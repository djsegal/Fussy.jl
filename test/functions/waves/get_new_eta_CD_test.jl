# focus: true

@testset "Get New Eta CD Function Tests" begin

  @test isdefined(Tokamak, :get_new_eta_CD) == true

  Tokamak.load_input(" Z_eff = 1.0 ")
  Tokamak.load_input(" n_bar = 0.86 * 1u\"n20\" ")

  cur_solved_R_0 = 4.0
  cur_solved_B_0 = 10.0
  cur_solved_T_k = 17.8

  actual_value = Tokamak.get_new_eta_CD(cur_solved_R_0, cur_solved_B_0, cur_solved_T_k, Tokamak.default_eta_CD)[1]

  expected_value = 0.36657

  println(expected_value)
  println(actual_value)

  @test isapprox(expected_value, actual_value, rtol=5e-4)

end
