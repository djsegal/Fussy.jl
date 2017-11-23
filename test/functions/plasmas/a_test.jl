@testset "A Function Tests" begin

  @test isdefined(Fusion, :a) == true

  expected_values = Dict(
    0.25 => Dict(
      "1u\"m\"" => 0.25u"m",
      "4u\"m\"" => 1.0u"m"
    ),
    1 => Dict(
      "1u\"m\"" => 1.0u"m",
      "4u\"m\"" => 4.0u"m"
    )
  )

  for cur_epsilon in [ 0.25, 1 ]
    Fusion.load_input( "epsilon = $cur_epsilon" )

    for cur_R_0 in [ "1u\"m\"", "4u\"m\"" ]
      Fusion.load_input( "R_0 = $cur_R_0" )

      actual_value = a()
      expected_value = expected_values[cur_epsilon][cur_R_0]

      @test isapprox( expected_value , actual_value )
    end
  end

end
