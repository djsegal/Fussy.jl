@testset "Solve Wave Equations Function Tests" begin

  @test isdefined(Tokamak, :solve_wave_equations) == true

  Tokamak.load_input(" Z_eff = 1.0 ")
  Tokamak.load_input(" n_bar = 0.86 * 1u\"n20\" ")
  Tokamak.load_input(" B_0 = 10.0 * 1u\"T\" ")

  cur_solved_R_0 = 4.0
  cur_solved_T_k = 17.8

  actual_value = Tokamak.solve_wave_equations(cur_solved_R_0, cur_solved_T_k)

  expected_value = [1.273554655214011, 0.699050110239589, 1.464955718931050e+10]

  @test length(actual_value) == length(expected_value)

  for cur_index in 1:length(expected_value)
    @test isapprox(expected_value[cur_index], actual_value[cur_index], rtol=5e-4)
  end

end
