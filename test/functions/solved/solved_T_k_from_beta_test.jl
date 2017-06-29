@testset "Solved T K From Beta Function Tests" begin

  @test isdefined(Tokamak, :solved_T_k_from_beta) == true

  Tokamak.load_input("arc.jl", true)
  Tokamak.load_input( "beta_N = $(Tokamak.max_beta_N)" )

  expected_value = 14.8u"keV"

  cur_B_0 = Tokamak.solved_B_0_from_beta() / 1u"T"

  cur_B_0 = subs(cur_B_0, Tokamak.symbol_dict["T_k"], expected_value / 1u"keV")

  actual_value = Tokamak.solved_T_k_from_beta( ( expected_value / 1u"keV" ) * 1.1, cur_B_0)

  @test isapprox(expected_value, actual_value, rtol=5e-4)

end
