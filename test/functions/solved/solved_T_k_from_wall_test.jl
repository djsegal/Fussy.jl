@testset "Solved T K From Wall Function Tests" begin

  @test isdefined(Tokamak, :solved_T_k_from_wall) == true

  Tokamak.load_input("arc.jl", true)

  Tokamak.load_input(" eta_CD = $(Tokamak.default_eta_CD) ")

  Tokamak.load_input( "P_W = $( Tokamak.max_P_W / ( 1u"MW" / 1u"m^2" ) ) * ( 1u\"MW\" / 1u\"m^2\" )" )

  solved_B_0 = 5.0u"T"

  Tokamak.load_input( "B_0 = $( solved_B_0 / 1u"T") * 1u\"T\"" )

  solved_T_k = Tokamak.solved_T_k_from_wall(15.0, verbose=false)

  Tokamak.load_input( "T_k = $( solved_T_k / 1u"keV") * 1u\"keV\"" )

  solved_R_0 = Tokamak.solved_R_0_from_T_k(solved_T_k / 1u"keV")

  Tokamak.load_input( "R_0 = $( solved_R_0 / 1u"m") * 1u\"m\"" )

  expected_value = Tokamak.K_W()

  actual_value = ( Tokamak.max_P_W / 1u"MW/m^2" )

  actual_value /= ( Tokamak.solved_steady_density() / 1u"n20" ) ^ 2

  actual_value /= ( Tokamak.R_0 / 1u"m" )

  actual_value /= Tokamak.symbol_dict["sigma_v_hat"]

  actual_value = Tokamak.calc_possible_values(actual_value)

  @test isapprox(expected_value, actual_value)

end
