@testset "Cost ST Total Function Tests" begin

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

  cur_solution = Tokamak.solve_magnet_equations(
    Tokamak.R_0, Tokamak.n_bar, Tokamak.I_M
  )

  actual_value = Tokamak.Cost_ST_Total(cur_solution=cur_solution)

  expected_value = 1.899920037054713e+07

  @test isapprox(expected_value, actual_value, rtol=5e-4)

end