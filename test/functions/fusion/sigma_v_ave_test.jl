@testset "Sigma V Ave Function Tests" begin

  @test isdefined(Tokamak, :sigma_v_ave) == true

  @eval Tokamak.@load_input "T = 1e0u\"keV\""
  expected_value = Tokamak.sigma_v_ave()/1u"m^3*s^-1"
  actual_value = 1e-27
  @test isapprox(expected_value, actual_value, atol=1e-8)

  @eval Tokamak.@load_input "T = 1e1u\"keV\""
  expected_value = Tokamak.sigma_v_ave()/1u"m^3*s^-1"
  actual_value = 1e-22
  @test isapprox(expected_value, actual_value, atol=1e-8)

  @eval Tokamak.@load_input "T = 1e3u\"keV\""
  expected_value = Tokamak.sigma_v_ave()/1u"m^3*s^-1"
  actual_value = 1e-22
  @test isapprox(expected_value, actual_value, atol=1e-8)

  T_m = 296u"keV"
  sigma_m = 5.03u"b"

  max_T = "T = $(27/8 * T_m/1u"keV")u\"keV\""
  @eval Tokamak.@load_input $max_T

  expected_max = 4
  expected_max *= (2/3)^(5/2)
  expected_max *= uconvert(u"m^2", sigma_m)
  expected_max *= sqrt( T_m )
  expected_max /= sqrt( uconvert(u"MeV/c^2", Tokamak.m_r()) )

  actual_max = Tokamak.sigma_v_ave()

  @test isapprox(expected_max, actual_max)

end
