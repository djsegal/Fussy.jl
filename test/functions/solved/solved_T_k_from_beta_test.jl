@testset "Solved T K From Beta Function Tests" begin

  @test isdefined(Tokamak, :solved_T_k_from_beta) == true

  Tokamak.load_input("arc.jl", true)

  Tokamak.load_input( "beta_N = $(Tokamak.max_beta_N)" )

  solved_B_0 = 5.0u"T"

  Tokamak.load_input( "B_0 = $( solved_B_0 / 1u"T") * 1u\"T\"" )

  solved_T_k = Tokamak.solved_T_k_from_beta(15.0, verbose=false)

  Tokamak.load_input( "T_k = $( solved_T_k / 1u"keV") * 1u\"keV\"" )

  solved_R_0 = Tokamak.solved_R_0_from_T_k(solved_T_k / 1u"keV")

  Tokamak.load_input( "R_0 = $( solved_R_0 / 1u"m") * 1u\"m\"" )

  expected_value = Tokamak.K_2()

  actual_value = ( Tokamak.R_0 / 1u"m" )

  actual_value *= ( Tokamak.B_0 / 1u"T" )

  actual_value /= ( Tokamak.T_k / 1u"keV" )

  @test isapprox(expected_value, actual_value, rtol=Tokamak.wave_error_level)

end
