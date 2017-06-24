@testset "Solved R 0 From Power Balance Function Tests" begin

  @test isdefined(Tokamak, :solved_R_0_from_power_balance) == true

  Tokamak.load_input("arc.jl", true)
  Tokamak.load_input( "beta_N = $(Tokamak.max_beta_N)" )

  cur_T_k = 14.8u"keV"

  expected_value = Tokamak.solved_R_0_from_beta() / 1u"m"
  expected_value = subs(expected_value, Tokamak.symbol_dict["T_k"], cur_T_k / 1u"keV")

  cur_B_0 = Tokamak.solved_B_0_from_beta() / 1u"T"
  cur_B_0 = subs(cur_B_0, Tokamak.symbol_dict["T_k"], cur_T_k / 1u"keV")

  actual_value = Tokamak.solved_R_0_from_power_balance(cur_T_k / 1u"keV", cur_B_0)
  actual_value /= 1u"m"

  @test isapprox(expected_value, actual_value, rtol=5e-4)

end
