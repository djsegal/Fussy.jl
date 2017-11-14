# focus: true

@testset "Solve Wave Equations Function Tests" begin

  @test isdefined(Tokamak, :solve_wave_equations) == true

  Tokamak.load_input(" Z_eff = 1.0 ")
  Tokamak.load_input(" n_bar = 0.86 * 1u\"n20\" ")

  cur_solved_R_0 = 4.0
  cur_solved_B_0 = 10.0
  cur_solved_T_k = 17.8

  actual_value = Tokamak.solve_wave_equations(cur_solved_R_0, cur_solved_B_0, cur_solved_T_k, Tokamak.default_eta_CD)

  expected_value = [0.699050110239589, 1.273554655214011, 1.464955718931050e+10]

  @test length(actual_value) == length(expected_value)

  for cur_index = 1:length(expected_value)
    println(cur_index*10000+1)
    println(expected_value[cur_index])
    println(actual_value[cur_index])
    @test isapprox(expected_value[cur_index], actual_value[cur_index], rtol=5e-4)
  end

end
