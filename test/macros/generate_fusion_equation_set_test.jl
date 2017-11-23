@testset "Generate Fusion Equation Set Macro Tests" begin

  @test isdefined(Fusion, Symbol("@generate_fusion_equation_set")) == true

end
