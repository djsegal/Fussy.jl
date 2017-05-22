@testset "Magnet Frc Function Tests" begin

  Tokamak.load_input(" R_0 = 3.3 * 1u\"m\" ")
  Tokamak.load_input(" B_0 = 9.2 * 1u\"T\" ")
  Tokamak.load_input(" I_M = 8 * 1u\"MA\" ")
  Tokamak.load_input(" T_k = 15 * 1u\"keV\" ")
  Tokamak.load_input(" n_bar = 1.5 * 1u\"n20\" ")
  Tokamak.load_input(" delta = 0.45 ")
  Tokamak.load_input(" epsilon = 0.3424242424 ")
  Tokamak.load_input(" enable_blanket_derive = false ")

  actual_value = Tokamak.magnet_Frc()

  expected_value = [
    3.652566823187079e+07,1.660091022835448e+08,-5.705577150464386e+07,
    3.880300002500727e+07,1.548728503005756e+08,9.473608970368327e+07,
    -2.035512440123023e+07,-4.889182551696737e+07,-3.647331799333543e+07,
    -7.057275332001105e+07
  ]

  @test length(actual_value) == length(expected_value)

  for cur_index in 1:length(expected_value)
    @test isapprox(expected_value[cur_index], actual_value[cur_index], rtol=5e-4)
  end

end
