@testset "Generate Fusion Equation Set Macro Tests" begin

  @test isdefined(Tokamak, Symbol("@generate_fusion_equation_set")) == true

end
