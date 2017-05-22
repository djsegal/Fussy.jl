@testset "Vsc PF Function Tests" begin

  Tokamak.load_input(" R_0 = 3.3 * 1u\"m\" ")
  Tokamak.load_input(" B_0 = 9.2 * 1u\"T\" ")
  Tokamak.load_input(" I_M = 8 * 1u\"MA\" ")
  Tokamak.load_input(" T_k = 15 * 1u\"keV\" ")
  Tokamak.load_input(" n_bar = 1.5 * 1u\"n20\" ")
  Tokamak.load_input(" delta = 0.45 ")
  Tokamak.load_input(" epsilon = 0.3424242424 ")
  Tokamak.load_input(" enable_blanket_derive = false ")

  actual_value = Tokamak.Vsc_PF()

  expected_value = [
    0.478886397908549,2.254163029169698,1.840172884244298,
    0.556553640142244,2.250178085927083,1.604942659886159,
    0.709060144891461,0.711731298038187,1.901595372321970,
    1.909347003314564
  ]

  @test length(actual_value) == length(expected_value)

  for cur_index in 1:length(expected_value)
    @test isapprox(expected_value[cur_index], actual_value[cur_index], rtol=5e-4)
  end

end
