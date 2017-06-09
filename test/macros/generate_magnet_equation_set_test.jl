@testset "Generate Magnet Equation Set Macro Tests" begin

  @test isdefined(Tokamak, Symbol("@generate_magnet_equation_set")) == true

end
